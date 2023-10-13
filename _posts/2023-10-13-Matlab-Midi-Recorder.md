---
layout: post
title: "Matlab Midi Recorder"
date: "2023-10-13 15:31:25 +0200"
categories: [techniques, resources]
author: Ravi Umadi
permalink: /:title
excerpt: Record midi files using MATLAB. Connect your digital piano to your computer and record keystrokes in midi format.
tags: [MIDI, Matlab, recording music]
---

Recording your composition in midi format is the most modern way of storing music. The advantages of midi files are too many to count. I am currently working on a project that involves teaching piano to special needs children. We needed a method to evaluate how well the children learn and track their progress. A key parameter is to follow the temporal progression of keystrokes and compare them to the template over time. The midi data fits perfectly for this purpose.

However, there is no in-built function for recording midi files in MATLAB&reg; There is hardware support for midi via Audio Toolbox. One can read midi messages from the instrument and even write messages to the instrument. But, one can not pass the incoming messages to a .mid file. Talk about a gaping hole! If they have not done it in the last 40 years of MIDI's existence, I have little hope that they will include this in the next update, which they implied in their reply to my query.

Meanwhile, I needed a solution. After digging around, I landed upon [Ken Schutte's 14-year-old work](https://kenschutte.com/midi/). It looked good enough for quick modification for passing incoming midi messages to a matrix and tweaking the `matrix2midi()` function a bit to make it work.

1. **Get [Matlab-midi](https://github.com/kts/matlab-midi)**

Here are the changes to make in the function `matrix2midi()`

Below the line #88
``` 
[junk,ord] = sort(note_events_ticktime);
```

Add
```
ord(junk==0) = [];
```
This ignores the zeros in noteOn/noteOff columns of the matrix.

Then, uncomment lines #108:109 and comment #111:112. This enables adding noteOff message when the midi files are read in, instead of noteOn with velocity 0. Here is the relevant piece from the function.
```matlab
if (note_events_onoff(ord(j))==1)
            % note on:
            midi.track(i).messages(msgCtr).type = 144;
            midi.track(i).messages(msgCtr).data = [trM(n,3); trM(n,4)];
        else
            %-- note off msg:
            midi.track(i).messages(msgCtr).type = 128;
            midi.track(i).messages(msgCtr).data = [trM(n,3); trM(n,4)];
            %-- note on vel=0:
%             midi.track(i).messages(msgCtr).type = 144;
%             midi.track(i).messages(msgCtr).data = [trM(n,3); 0];
        end
```

2\. **MIDILogger**

Now, the script that records the midi files. See below for GitHub repo.

When you run this script, a figure window pops, from where the keypress commands are read in. Press `s` to start recording, and `x` to stop. The .mid files are generated with `timestamp-username.mid` format and stored in the `rec/` folder. Change the `recpath` in the script if you wish to store the files elsewhere.


```matlab
% MidiLogger
% Record .mid files via MATLAB from digital music instruments. Built on Ken
% Schutte's matlab-midi: https://kenschutte.com/midi/
% Also see MATLAB Midi devices documentation:
% https://www.mathworks.com/help/audio/ug/midi-device-interface.html
% Author: Ravi Umadi, 2023

% Parameters
noteOn = 144:144+16; % See midi specs 
% https://midi.org/specifications-old/category/reference-tables
noteOff = 127:127+16;

% Define the MIDI input device ID
availableDevices = mididevinfo;

% Edit the line below for slecting your device
midiInputID = availableDevices.input(1).ID;

% Define path for storing midi files
if ~exist('rec', 'dir')
    mkdir('rec')
end
recpath = "rec";

% Get user name. If not needed, also remove from midiFileName, see below
username = [];
while isempty(username)
    username = input("Enter the name of the player:     ", 's');
end

% Creare a midi device
midiIn = mididevice(midiInputID);

% Define the MIDI file name (seems unused, but included it anyway)
midiFileName = fullfile(recpath, strcat(string(datetime('now',...
    'format', 'uuuu-MM-dd-HH-mm-ss-')), username, '.mid'));

% Define midi matrix
MidiMatrix = zeros(1,6);

figure; % Create a figure to capture the key press

% Initialize flag to stop loop
global stopLoop;
stopLoop = false;

% Set the key press function
set(gcf, 'KeyPressFcn', @(src, event) checkKeyPress(event));

% Prompt begin
disp("Press 's' to start recording")

% Wait for 's' key to start the loop
while true
    waitforbuttonpress;
    if gcf().CurrentCharacter == 's'
        break;
    end
end

disp("Recording started... Press 'x' to stop.");

% Loop until 'x' key is pressed
while ~stopLoop
    % Receive MIDI messages
    midiMessages = midireceive(midiIn);

    % Check if there are new messages
    if ~isempty(midiMessages)
        % Loop through the received MIDI messages
        for i = 1:numel(midiMessages)
            midiMessage = midiMessages(i);

            % Check note on/off
            if ismember(midiMessage.MsgBytes(1), noteOn)
                entryCol = 5;
            elseif ismember(midiMessage.MsgBytes(1), noteOff)
                entryCol = 6;
            else
                continue; % ignore control commands
            end
            
            % Add to the matrix. See examples in matlab-midi
            MidiMatrix(end+1,[1:4, entryCol]) = [1, midiMessage.Channel,...
                double(midiMessage.MsgBytes(2)), ...
                double(midiMessage.MsgBytes(3)), midiMessage.Timestamp];
        end
    end

    % Optional: Add a delay to control the rate of recording
    pause(0.1); % Adjust the delay as needed
end

% Close the figure
close(gcf);

% Process notes and write out midi file
MidiMatrix(1,:) = [];
midiFileStructure = matrix2midi(MidiMatrix);
if exist('midiFileStructure', 'var')
    writemidi(midiFileStructure, midiFileName);
end

clear midiIn;

% % Process midi file in system
% ! timidity -o output.wav -Ow output.mid
% ! play output.wav

% Function to check key press
function checkKeyPress(event)
global stopLoop;
if strcmp(event.Key, 'x')
    stopLoop = true;
    disp("Recording Stopped");
end
end


```
<div class="button-container">
  <a href="https://github.com/raviumadi/MIDILogger" class="btn">View on GitHub Repo</a>
</div>

You could use `timidity` or any software synthesiser to generate `.wav` files of your composition. 

## Limitations
In the current version, the control commands are ignored. Please send a pull-request if you would like to take it from here.

Happy Recording!