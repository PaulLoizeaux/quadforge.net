---
layout: post
title: "Mission Computer Update"
date: 2013-4-4
---

<img src="Mission Computer.jpg"/>

The programming team has been hard at work automating a data transfer between the mission computer mounted on the quadrotor (an Android-based device) and a remote ground station that acts as its own wireless access point.

The team installed <a href="http://openwrt.org/">open source firmware (OpenWrt)</a> on a TP-LINK Portable 3G/4G Wireless N Router (model# TL-MR3020), allowing any connected device to transfer data from the limited hard drive space available on the router.

A number of different transfer protocols were looked into, but an HTTP transfer proved to be the most feasible. The router acts as a “website” that the mission computer on the quadrotor can “visit” and download whatever data may be hosted. The Android development toolkit proved to be invaluable in this process, as it provides a built in download manager that handles HTTP transfers once they are queued up.

The automation of planned data transfers is a big step towards our 2013 goals for the BlackBat, and the programming team hopes to continue developing innovative, open source applications for the onboard mission computer.