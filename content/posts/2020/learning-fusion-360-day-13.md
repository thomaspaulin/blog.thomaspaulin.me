---
title: "Learning Fusion 360 in 30 Days - Day 13"
date: 2020-07-03
tags: ["cad", "fusion-360", "autodesk", "challenges", "30-day-challenge", "fusion-360-in-30"]
draft: true
---
### Project
Bodies vs. Components

### Lessons Learned
 Fusion 360 uses 'top-down' assembly, Inventor/Solidworks use 'bottom-up' assemnly
    - Bottom-up = create parts individually then assemble them. If you change an individual part, you better know where it is used and update them accordingly
        - No link between parts
    - Top-down = build all parts within the assembly yourself there
        - Parts are linked so they can be automatically updated as you make changes
- Kevin Kennedy recommends planning model before the first sketch
- Bodies
    - Modelling tools
        - e.g. mug has a body for the cylindrical part, and the handle
    - Cannot be copied to another file unless in direct modelling mode, and the design timeline is not cached
    - Don't show in a part list
    - Independent of parents when made in patterns
    - Solid, sculpt, and mesh types
- Components
    - Represent real life or manufactured parts
    - Can be copied
    - Change when the parent does
    - Cannot be made from sketches
    - Can have joints
    - Can activate
    - Good for parts, subassemblies, joints
- Always start your file with a new component

### Completed Project
None
