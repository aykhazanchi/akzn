---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
categories: ["photos"]
tags: ["photos"]
DisableComments: true
draft: true
---

{{< figure title="{{ replace .Name "-" " " | title }}" src="/photos/{{ .Name }}/{{ .Name }}.png" alt="{{ .Name }}" width="50%" height="50%" >}}

<br>

---