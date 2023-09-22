---
layout: page
title: "Resources"
permalink: /Resources/
---
**Here are links to sounds, media, pieces of code, templates etc. in addition to posts containing such material.**
<hr class="bottom-line">
  <div class="centered-justified-links">
      <a href="/bat-calls">Bat Calls</a>
      <a href="/bird-calls">Bird Calls</a>
      <a href="/insects">Insects</a>
      <a href="/pictures">Pictures</a>
      <a href="/miscellaneous">Misc.</a>
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

