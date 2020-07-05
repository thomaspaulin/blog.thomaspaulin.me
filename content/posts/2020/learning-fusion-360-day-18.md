---
title: "Learning Fusion 360 in 30 Days - Day 18"
date: 2020-07-08
tags: ["cad", "fusion-360", "autodesk", "challenges", "30-day-challenge", "fusion-360-in-30"]
draft: false
---
### Project
Converting a STL mesh to a solid body

### Lessons Learned
- Mesh files use verticies, edges, and faces to form polygons, and surfaces
- Meshes are surface models - comparable to origami in that an object is formed, but hollow
- STL standard format for stereo lithography printing
- OBJ similar to STL, displays surface data such as colour and texture
- "BREP"
    - Boundary representation
    - Solid and watertight, opposite of STL in a way
- 'Move to ground' if imported mesh is flying
- Need to turn off design history to enter the mesh workspace
    - Right click the file in Fusion 360 browser
    - In the mesh workspace you can tweak the mesh
- Despite being a mesh, you need to be in the modelling workspace to convert to a BREP
    - Right click on the mesh in the Fusion 360 browser to do so
    - Sometimes there will be a warning of too many faces (Fusion 360 can handle up to ~50k). Can use reduce in the mesh workspace
- Paint selection with select priority applied makes selection of triangles in the file much simpler

### Completed Project
[Phone stand](https://a360.co/31MiUSH)
- Some issues with the final step because the patch command was not joining the faces as expected. I've not yet resolved this issue at the time of writing and will considering doing so should I ever use patch again as part of a 'real-life' project
