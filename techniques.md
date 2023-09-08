---
layout: page
title: Techniques
permalink: /Techniques/
---

{% for post in site.posts %}
  {% if post.categories contains 'techniques' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p> {{ post.excerpt }} </p>
  {% endif %}
{% endfor %}
