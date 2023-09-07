---
layout: post
title: "How To Record Bats"
date: 2023-09-07
categories: techniques
author: Ravi Umadi
excerpt: Learn a method of recording bat calls and visualising bat calls. 
---

# Introduction

Recording bat calls is fun - for a nerd like me. However, with just a few basic technical details, I will show you how to do it most effectively without writing code. However, as an academic researcher involved in much deeper techniques, I prefer to do it the programming way. In a later post, I will describe the MATLAB code and procedure. Try the easier way now and have fun looking at the recordings.

## Software You Will Need
1. [Audacity](https://www.audacityteam.org)
2. [Sonic Visualiser](https://www.sonicvisualiser.org)

Both of these are free and work on Win/Mac/Linux


## Hardware You Will Need

This is where it can get expensive, but there are cheaper alternatives. If you are interested in music production or biosonics, you may own a sound card with HD audio capabilities. If not, look for inexpensive options. You will need a sound card with at least a 192kHz sampling rate.  
A couple of options are:

1. [Behringer U-Phoria UMC202HD](https://www.thomann.de/de/behringer_u_phoria_umc202hd.htm?gclid=CjwKCAjw6eWnBhAKEiwADpnw9s6CjrdA6okuVKSGvMGODJtVnMepmY3tBRN7wljoI8C-GdJorVUnohoC1ioQAvD_BwE)
2. [Focusrite Scarlet 2i2](https://focusrite.com/products/scarlett-2i2-3rd-gen?setCurrencyId=6&gclid=CjwKCAjw6eWnBhAKEiwADpnw9vBb7CA9rg5fm1ZCMU1Eu09FEJT21PWod-A0-fTgMI5oNXUNbb0o6xoCsW0QAvD_BwE)


Along with these, you will need an analogue microphone. These come in all varieties. In my experience, the best option has been the recently available "reference quality" microphones.

1. [Behringer ECM-8000 Messmikrofon](https://www.thomann.de/de/behringer_ecm_8000.htm)
2. [Other in this list](https://www.thomann.de/de/messmikrofone1.html)

Your pick will depend on your budget, of course.

I have tested the ECM-8000 microphone and compared the frequency response against the [SANEKN CO-100K](https://sanken-mic.com/en/product/product.cfm/3.1000400), a RODE NT5, and a custom build microphone.. Here are the results. 
![Frequency Response Comparision for the Cheapest Measuring Microphone Behringer ECM-8000](~/images/ecm8000FRC.png)

### How was the frequency response calculated?
I recorded a 5-second white noise from two channels of an RME Babyface and analysed the signals in MATLAB. Here is the example code.

This analysis part is for those interested in using the ECM-8000 microphone. It is a pretty good option, except for its sensitivity. However, the frequency response is quite comparable.

~~~matlab
% MATLAB 
[signal, fs] = audioread('rec.wav');
% Normalise
signal = signal/max(signal);
% Calculate spectrum
[s_mag, s_freq] = pspec(signal, fs);
%  Calculate envelope
mag = envelope(s_mag, 2000, "rms");
% Take the differences
freq_response_differential = smooth(abs(mag(:,1)) - abs(mag(:,2)));
% Visualise
plot(freq_response_differential, 'k', 'LineWidth', 1)
~~~
## Let's Record!

1. Connect the microphone to the sound card and the sound card to the computer, and power it up.
2. Launch Audacity and select the driver for the sound card, channels, and sampling rate.
3. Then just hit record.
4. Test record with juggling keys.
5. You should check your sound settings. Windows sets the sampling rate to 48kHz by default. The audacity settings don't necessarily relay to the OS. On MacOS, launch  Audio MIDI Setup and select the sampling rate.
6. If everything goes well, and given that you set up your recording where the bats are active during the night, you should have recordings with bat calls.
7. Typical bat calls look like in the picture below.

![Bat Calls](~/images/batCallPhasesExample.png)

This recording was taken in an orchard in the summer of 2021 in Southern Germany.

You will notice a few things in this picture.
1. Every click is followed by at least one echo - a stream of them, but it is invisible in waveform.
2. The clicks get more frequent as the sequence progresses, ending in very rapid calls - called a buzz phase—more on that in another post.

## Looking at Data
Open your .wav files in Sonic Visualise and press `g` on your keyboard. This brings up the spectrogram view. You can set the resolution and aspect ratio with the little turning wheel. You will see something like this:

![Bat Calls Spectrogram](~/images/spectrogramBatCalls.png)

That's the gist of it. Congratulations if you managed to get this far.

Disclaimer: The products listed here are not sponsored. These are some of the tools I use in my research work.
