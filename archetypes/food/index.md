---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
categories: ["food"]
tags: ["food", "photo"]
DisableComments: true
draft: true
---

{{< figure src="/food/lappis-meals/{{ .Name }}/images/{{ .Name }}.jpeg" alt="{{ .Name }}" width="50%" height="50%" >}}

<br>