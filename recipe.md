---
layout: page
title: Recipe
permalink: /Recipe/
---

{% for post in site.posts %}
  {% if post.categories contains 'recipes' %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <h6> {{ post.date }} . {{ post.author }} </h6>
  <p>{{ post.content | strip_html | truncatewords: 50 }} <a href="{{ post.url }}">Read more</a></p>
  {% endif %}
{% endfor %}


-----------

**Cite As:**  Umadi, Ravi ({{ site.time | date: "%Y" }}). {{ page.title }},  _Retrieved from https://biosonix.io{{ page.url }}_