---
layout: post
title: "A Simple Sound Recorder"
date: "2023-10-07 11:39:01 +0200"
categories: [techniques, resources]
author: Ravi Umadi
permalink: /:title
excerpt: Here is a simple but rather handy sound recorder using Matlab command window. Works with the on-board audio device or any external sound card. Record and save data, mark times and control recording, all with a few keys.
tags: [sound recorder, Matlab, bioacoustics, audio data, voice recorder]
---
As a student of bioacoustics, and working with many devices, I often felt the absence of a quick recording method to access the sound cards and record at high sampling rates. Most of my experimental programs are elaborate and designed for specific tasks. 

However, obtaining data should not be that difficult.

Hence, this Basic Matlab Sound Recorder does what one might need in a hurry: record, mark events of interest, and save data. 

<div class="button-container">
	<a href="https://github.com/raviumadi/Basic-Matlab-Sound-Recorder" class="btn">Download the tool from GitHub</a>
</div>


# Basic-Matlab-Sound-Recorder

A simple tool for quickly recording sounds using MATLAB&reg; command window.

**Check `/examples` for a working demo**

You can control the recording process with simple key presses.

> Sound Recorder
>
> CONTROLLER KEYS
>
> s --> Start
>
> p --> Pause/Resume
>
> t --> Add Timestamp (ROI)
>
> d --> Interim Data
>
> x --> Stop and get data

1. Call `displayAudioDeviceInfo` function to list the available inputs and outputs.

2. Call `SoundRecorderController` without arguments for recording from default input at 44.1 kHz.

3. You may use `SoundRecorderController(deviceID, channelNumbers, numChannels, fs)` where the deviceID is known from 1
4. Use `help SoundRecorderController` to see the details of the remaining parameters
5. Mark regions of interest by pressing `t` to obtain timestamps of the event. This comes in handy for post-processing
6. Extended use: Incorporate into script designs for writing out `.wav` and clipping from timestamp etc.

Have fun!

