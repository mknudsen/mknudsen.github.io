---
layout: page
title: Tools
description: "A list of small web tools and utilities hosted on linkhalde, including calculators, pickers, and bookmarklets."
---
{% assign subdir = 'tools/' %}
{% for page in site.pages %}
{% if page.path contains subdir and page.url != page.dir %}
- [{{ page.title | default: page.url }}]({{ page.url | relative_url }})
{% endif %}
{% endfor %}
