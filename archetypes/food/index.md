---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
thumbnail:  "food/lappis-meals/{{ .Name }}/images/{{ .Name }}.png"
categories: ["food"]
tags: ["food", "photo"]
DisableComments: true
draft: true
---

{{< figure src="/food/lappis-meals/{{ .Name }}/images/{{ .Name }}.png" alt="{{ .Name }} width="50%" height="50%" >}}

<br>

---