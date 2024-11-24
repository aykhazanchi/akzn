---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
categories: ["travel"]
tags: ["travel"]
DisableComments: true
draft: true
---

{{< figure title="{{ replace .Name "-" " " | title }}" src="/travel/{{ .Name }}/{{ .Name }}.png" alt="{{ .Name }}" width="50%" height="50%" >}}

<br>