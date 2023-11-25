---
layout: post
title: "A Digital Metronome"
date: "2023-11-24 21:59:32 +0100"
categories: [techniques, resources] 
author: Ravi Umadi
permalink: /:title
excerpt: A metronome makes and keeps the rhythm and is a most useful tool for any musician. For electronic projects involving music, a simple microcontroller-based metronome can be easily incorporated. Here I describe such an approach.
tags: []
---

# Backstory

A couple of weeks ago, I walked into a music store in Munich, thinking about picking up a decent metronome for a reasonable price. It turns out, metronomes can be expensive, anywhere from 50 euros to over 200. That would be worth spending for a musician. For someone developing music-related projects, and only remotely interested in picking up any musical skills, I decided that building one would be a better option. After all, it is only a matter of keeping count of time and sending out a signal. With that inspiration (and a mild snorty attitude toward expensive musical tools), I walked out of the store and picked up my breadboard.

<div class="button-container">
  <a href="https://github.com/raviumadi/Digital-Metronome" class="btn">Download from GitHub Repo</a>
</div>

## Components

- ESP32 or equivalent
- Buzzer/Speaker
- Two buttons - BPM up and down
- Pull up resistors
- LED for visual - optional
- Adafruit SSD1306 display module
- Breadboard and wires

## Builds

<div style="text-align: center;">
  <img src="/images/Metronome1.jpeg" alt="Digital metronome, prototype 1" width="" height="">
  <p class="image-caption">The 0.25W speaker clicks when the HIGH is sent out from the GPIO. The LED flashes with every tick, for added visual cue.</p>
</div>

<div style="text-align: center;">
  <img src="/images/Metronome2.jpeg" alt="Digital metronome, prototype 2" width="" height="">
  <p class="image-caption">Improved build. The two toggle switches rise or lower beats per minute by 10 with every press. The information is displayed in the 0.96" OLED.</p>
</div>

## Improvements
The audio output leaves much room for development. A dedicated module programmed with a quality sound signal triggered upon signal would be an ideal component.

The BPM switches could be replaced with a potentiometer knob for finer adjustments and reduced components.

## Housing
I did not design a housing for this, as it is going to be included in another project. But I would be curious to know what you came up with as a housing design. Do share. If you would like to add the designs to the repo, send a request.

Have fun!
