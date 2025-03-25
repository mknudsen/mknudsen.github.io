---
layout: page
title: Finance
---

{% for somePage in site.pages %}
{% if somePage.url contains 'finance/' and somePage.url != page.url %}
- <a href="{{ somePage.url }}">{{ somePage.title }}</a>
{% endif %}
{% endfor %}
