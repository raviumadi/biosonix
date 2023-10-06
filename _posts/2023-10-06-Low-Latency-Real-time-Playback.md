---
layout: post
title: "Low Latency Real-time Playback"
date: "2023-10-06 14:54:29 +0200"
categories: techniques
author: Ravi Umadi
permalink: /:title
excerpt: Achieving very short delay in signal processing for quick playback in experimental set-ups is a challenge often encountered by researchers studying animal behaviour. This technique shows a useful method along with a method to measure the latency of the system for developing audio-neuro playback-record experiments.
tags: [method, real-time signal processing, playback experiments, bioacoustics, auditory neuroscience]
---

In auditory-related experiments, achieving a quick turn-around time with signal processing is an important aspect of experimental design. Whether one wants to playback the same signal as received at the microphone, modify it and then playback, or in yet another paradigm of neuroscience experiments, playback the sounds and record from the brain, it is necessary to set up experimental conditions that mimic natural settings. 

For instance, to playback a sound within a natural time window of receiving an echo of an echolocating bat, the researcher needs to control the latency and adjust for various acoustic modifications and may incorporate test conditions. All this processing needs to happen so fast that a behaving animal perceives the playbacks as naturalistically as possible.

The following technique demonstrates how to achieve this using VST plug in from [SoundMexPro&reg;](https://soundmexpro.hz-ol.de). This is also achievable using MATLAB&reg; Audio Toolbox, but that technique is for another post. 

## Set up
	microphone-->Input ch.1-->VST process-->[Output ch.1-->Input ch.2]--loopback

	To test the latency encoutned by applying a bandpass filter using a VST plugin in soundmexpro, I processed the signal from a microphone and recorded the processed signal from a second channel. By cross correlating the two recorded sigal, I find the overall latency.

	**Factros affecting the latency**
	The ASIO driver buffer size - Select it such that xruns are minimised/completely eliminated. In my testing I used 96/64 samples 
	Framelength - if the 'recbufsize' increases, the processing may slow down.
	The applied delay to control for playback latency - experimental requirement. Use the varaible ir_delay to introduce a desired playback latency.

## Code
Now the core part:

```matlab
% MATLAB

%% Input and IR processing via VST

fs = 192e3;
framelength = fs/2;

% bandpass IR for convolution
ir_delay=0;   % delay (s) applied to the input
ir_highpass=500;
ir_lowpass=1000;
ir_order=256;

ir=fir1(ir_order,[2*ir_highpass/fs 2*ir_lowpass/fs]);
long_ir=[zeros(1,round(ir_delay*fs)) ir];
% stereo_ir=[long_ir' long_ir'];
stereo_ir=[long_ir' zeros(length(long_ir),1)]; % processing only the signal from ch.1. zeros are ignored by smp
audiowrite('test_ir.wav',stereo_ir,fs,'BitsPerSample',32);

%
if ~exist('number', 'var')
    number = [];
end
if isempty(number)
    % Get drivers and prompt for input, if there are more than one drivers.
    [success, driver] = soundmexpro('getdrivers');
    if success ~= 1
        disp('Could not get drivers!')
    else
        if length(driver) > 1
            disp(driver)
            prompt = 'Enter the desired ASIO driver number: ';
            number = input(prompt);
        else
            number = 1;
        end
    end
end

soundmexpro('init', ...     
    'driver', driver(number) , ...   
    'samplerate', fs, ...
    'output', 0, ...   
    'input', [0 1], ...    
    'track', 2 ...    
    );
% retrieve properties 
[success, samplerate, buffersize, supported_rates] = soundmexpro('getproperties');
if (~success)
    error(['error calling ''getproperties''' error_loc(dbstack)]);
end

% device visualization - remove for faster processing
if 1 ~= soundmexpro('show')
    error(['error calling ''show''' error_loc(dbstack)]);
end

% set record buffer size to N samples
if 1 ~= soundmexpro('recbufsize', ...  
        'value', framelength ...              % buffer size in samples
        )
    error(['error calling ''recbufsize''' error_loc(dbstack)]);
end

if 1 ~= soundmexpro('recpause', ...    
        'value', 0 ...               
        )
    error(['error calling ''recpause''' error_loc(dbstack)]);
end

% set input-output
if 1~=soundmexpro('iostatus', 'input', [0 1], 'track', [0 1])
    error('error setting io status')
end

if 1 ~= soundmexpro('vstload', ...
        'filename', 'C:\SoundMexPro\plugins\HtVSTConv.dll', ...
        'type','track', ...
        'input', [0 1], ...
        'output', [0 1], ...
        'position', 0 ...                       
        )
    error('error calling vstload');
end

% load the impulse response
if 1 ~= soundmexpro('vstprogramname', ...
        'type','track', ...
        'input',[0 1], ...
        'position', 0, ...                           
        'programname', 'test_ir.wav' ...
        )
    error(['error calling ''vstprogramname''' error_loc(dbstack)]);
end

soundmexpro('start','length',0);

xcount = 1;
figure(1)
tic
recdata = [];
recpos = 0;
while round(toc) <=5
     [success, recbuf, pos] = soundmexpro('recgetdata');
    if success ~= 1
        clear soundmexpro
        error(['error calling ''recgetdata''' error_loc(dbstack)]);
    end
    xcount = xcount+1;
    if max(recbuf(:,2))>0.01
        [xc, loc] = xcorr(recbuf(:,2), recbuf(:,1));
        [~, lc] = max(xc);
        lat = (loc(lc)./fs)*1000;
        plot(xcount, lat, 'r.', 'MarkerSize', 10)
        ylim([0 25])
        xlabel("Frame number")
        ylabel("Latency, ms")
        yline(20)
        hold on
        drawnow
    end
end
subtitle("Latency at each \it{recbuf}")
 % Check for dropouts
    [success, xrun, proc_xruns, done_xruns] = soundmexpro('xrun');
    if success ~= 1
        error(['error calling ''xrun''' error_loc(dbstack)]);
    end
    disp(['There were ' int2str(xrun) ' xruns (' int2str(proc_xruns)...
        ' in processing queue, ' int2str(done_xruns) ...
        ' in  visualization/recording to disk queue)']);
if 1 ~= soundmexpro('stop')
    error(['error calling ''stop''' error_loc(dbstack)]);
end
soundmexpro('exit');
```

Now analyse the recordings and visualise the latency

```matlab
% MATLAB

%% Analyse the delay
in1 = audioread('rec_0.wav');
in2 = audioread('rec_1.wav');

[xc, loc] = xcorr(in2,in1);
[pk, lc] = max(xc);
reclat = (loc(lc)./fs)*10e2;

figure(2)
subplot(2,1,1)
plot(in1), hold on, plot(in2)
xlabel("Time, s")
title(strcat("Playback latency with VST convolution is :",...
    num2str(round(reclat,2)), "ms"))
subtitle(strcat("@ buffer size: ", num2str(buffersize), " samples"))

subplot(2,1,2)
plot(loc./fs, xc)
hold on
plot(loc(lc)./fs, pk, 'ro')
xlim([-0.5 0.5])
xlabel("Time, s")
subtitle("Cross Correlation of Two Inputs")
```
Here are the results of my tests.

**Device:** RME Babyface

<div style="text-align: center;">
  <img src="/images/2023-10-06-Low-Latency-Real-time-Playback-1.png" alt="" width="" height="">
  <p class="image-caption">A 20ms threshold is highlighted, as this was a requirement for a researcher. </p>
</div>

<div style="text-align: center;">
  <img src="/images/2023-10-06-Low-Latency-Real-time-Playback-2.png" alt="" width="" height="">
  <p class="image-caption">The buffer size here refers to the audio device buffer size set in ASIO settings. In the code, it is obtained by the <em>getproperties</em> command</p>
</div>

I hope you found this useful. I would be interested to hear how you applied this in your experiments.
