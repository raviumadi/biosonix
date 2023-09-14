---
layout: page
title: ಕನ್ನಡ
permalink: /kannada/
---

{% for post in site.posts %}
  {% if post.categories contains 'kirulekhana' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p>{{ post.content | strip_html | truncatewords: 50 }} <a href="{{ post.url }}">Read more</a></p>
  {% endif %}
{% endfor %}

