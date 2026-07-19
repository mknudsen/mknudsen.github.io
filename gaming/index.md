---
layout: page
title: Gaming
description: "An index of gaming-related pages on linkhalde, including Xbox backwards compatibility lists and played games."
---

{% for somePage in site.pages %}
{% if somePage.url contains 'gaming/' and somePage.url != page.url %}
- <a href="{{ somePage.url }}">{{ somePage.title }}</a>
{% endif %}
{% endfor %}