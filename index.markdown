---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

Echolocation is a fascinating field of research. Unlike visual phenomena, which are more intuitive to humans, the acoustic world is passively present in our lives and unfolds in our appreciation of music and day-to-day chatter. However, we pay little attention to the science of sound in everyday life.

Understanding how we perceive sounds is vastly different from understanding how other animals do. When thinking about vocally active animals, one might immediately ponder how various species use vocal communication. Birds, big mammals, and even insects come to mind, for we can hear and, to a certain extent, romanticise some of these sounds. However, the power and functionality of sounds are nowhere more glorified than how some marine mammals and bats use them - for navigating, locating, tracking and hunting prey. These animals depend on their auditory senses more than their vision and can do well without the latter.

Auditory sense stands out from vision because it deals with signals propagating much slower than light. This fact leads to a host of peculiar phenomena that the auditory system has to process, often benefitting from them. For instance, the inter-auricular time difference is an essential cue in localising the source of the sounds in the azimuth. Similarly, many animals can perceive phase differences as well, unlike humans. The Doppler effect - an apparent shift in the perceived frequency depending on relative motion between the observer and the source - has critical implications for echolocating animals - and is an outstanding example of adaptive behaviour in bats that use constant frequency calls for echolocation. I could go on about many wonderous examples of sensory adaptations to accommodate the physics of sound. That is what makes the science of bioacoustics such an exemplary field of biological research. In brief, the field spans the sections of neurobiology through physiology and mechanistic studies to behavioural research, and that only touches a few corners. This highly interdisciplinary field is a bottomless magical well where the deeper you dive, the more unique things you discover, and the deeper you want to dive!




































<!-- ![Flying Bat](/images/) -->


--------------------------------------------------
{% for post in site.posts | reverse | limit: 5 %}
  <h4><a href="{{ post.url }}">{{ post.title }}</a></h4>
  <!-- <h6> {{ post.date }} . {{ post.author }} </h6> -->
  <p> {{ post.excerpt }} </p>
{% endfor %}
