---
layout: page
title: Techniques
permalink: /Techniques/
---

{% for post in site.posts %}
  {% if post.categories contains 'techniques' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date | date: "%B %d %Y" }} . {{ post.author }} </h6>
  <p>{{ post.content | strip_html | truncatewords: 50 }} <a href="{{ post.url }}">Read more</a></p>
  {% endif %}
{% endfor %}
