---
layout: page
title: Gaming
---

{% for somePage in site.pages %}
{% if somePage.url contains 'gaming/' and somePage.url != page.url %}
- <a href="{{ somePage.url }}">{{ somePage.title }}</a>
{% endif %}
{% endfor %}