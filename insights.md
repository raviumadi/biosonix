---
layout: page
title: Insights
permalink: /Insights/
---

{% for post in site.posts %}
  {% if post.categories contains 'insights' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p> {{ post.excerpt }} </p>
  {% endif %}
{% endfor %}

-----------
**Cite As:**  Umadi, Ravi ({{ site.time | date: "%Y" }}). {{ page.title }},  _Retrieved from https://biosonix.io{{ page.url }}_