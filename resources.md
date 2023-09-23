---
layout: page
title: "Resources"
permalink: /Resources/
---
**Here are links to sounds, media, pieces of code, templates etc. in addition to posts containing such material.**

_Contents may be under construction_
<hr class="bottom-line">
  <div class="centered-justified-links">
      <a href="/Bat-Calls">Bat Calls</a>
      <a href="/Bird-Calls">Bird Calls</a>
      <a href="/Insects">Insects</a>
      <a href="/Pictures">Pictures</a>
      <a href="/Miscellaneous">Misc.</a>
    </div>
<hr class="bottom-line">

<!-- Add posts with resources category -->
{% for post in site.posts %}
  {% if post.categories contains 'resources' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p>{{ post.content | strip_html | truncatewords: 50 }} <a href="{{ post.url }}">Read more</a></p>
  {% endif %}
{% endfor %}

