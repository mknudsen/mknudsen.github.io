---
layout: page
title: Finance
description: "An index of finance-related pages and tools on linkhalde, including a personal finance link hub."
---

{% for somePage in site.pages %}
{% if somePage.url contains 'finance/' and somePage.url != page.url %}
- <a href="{{ somePage.url }}">{{ somePage.title }}</a>
{% endif %}
{% endfor %}
