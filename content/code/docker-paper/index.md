---
title: Analyzing Dockerized Web App Performance Through Load Testing
date: 2022-11-09
categories: ["code", "research"]
tags: [code, research, docker, nodejs, express, mysql, prisma, api, prometheus, grafana, jmeter, iostat]
skills: [NodeJS, Express, MySQL, Prisma, API development, Docker, Research]
series: []
DisableComments: true
draft: false
---

Code for the test experiment setup for analyzing dockerized web app performance through load testing. More about the research can be found here: [Github Link](https://github.com/aykhazanchi/expensy)

This was a research project conducted during the II2202 Research Methodology and Scientic Writing class at KTH Royal Institute of Technology, Sweden. The abstract is below and the full report can be viewed with the link at the end.

_Abstract_
<br>
Containerization offers many benefits to developers such as ease of deployment, increased flexibility, scalability, and elasticity leading to wide adoption of the technology. However, optimizing the performance of deployed applications is of vital importance, and applications running on bare metal will often outperform those running in virtual environments due to the additional overhead of the virtualization layer. The purpose of the project is to investigate the performance impact of I/O in containerized web apps under varying number of concurrent connections and payload size. We simulate this by running Apache JMeter load tests on a web application built using NodeJS and ExpressJS, two well-known Javascript web server frameworks. The webapplication reads and writes queries to a MySQL database also deployed in a container. We believe that container performance suffers due to the I/O layer for data-intensive workloads. The aim of this project was to identify where and by how much the container I/O becomes a limiting factor in web application performance. Our results show that I/O becomes a bottleneck in the performance of containerized web applications long before the CPU and memory utilization are saturated. We identify significant performance degradation in I/O-intensive workloads caused by container I/O becoming a limiting factor due to the additional virtualization layers read-write requests go through in Docker Desktop. We believe these results will facilitate better design decisions based on insight into the kind of overhead that accompanies containerization, thus leading to more resource-optimal and sustainable software designs.

[First version of final report](https://drive.google.com/file/d/1D9dVtzgL_clhaT_QjRUC-28xaUVD8AzV/view "PDF")

<br>