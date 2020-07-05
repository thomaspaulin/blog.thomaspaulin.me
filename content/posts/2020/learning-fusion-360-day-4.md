---
title: "Learning Fusion 360 in 30 Days - Day 4"
date: 2020-06-24
tags: ["cad", "fusion-360", "autodesk", "challenges", "30-day-challenge", "fusion-360-in-30"]
draft: false
---
### Project
Whisky bottle

### Lessons Learned
- The order of profile selection matters when using the loft tool
- You can use the timeline to add new aspects to features retrospectively by editing each item. Then everything will be applied automatically to the changed feature
- The loft tool can use 'guide rails' to inform the shape taken by the loft command
    - Guide rails can be formed using any geometric shape, but when combining them, such as by spline with line, they must be joined and form a continuous path rather than be two separate paths
        - To do this with a line and spline, you should snap the fit handle to the line until they coincide
- The join operation in extrude joins it to the body whose surface the sketch is on. In this case it's used so there's one single body for the shell operation
- Modelled checkbox within the thread dialog ensures it creates the 3d model of the thread, not just a graphic

### Completed Project
[Whisky bottle](https://a360.co/38rLWIm)
