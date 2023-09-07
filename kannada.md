---
layout: page
title: ಕನ್ನಡ
permalink: /kirulekhanagalu/
---

{% for post in site.posts %}
  {% if post.categories contains 'kirulekhana' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p> {{ post.excerpt }} </p>
  {% endif %}
{% endfor %}

