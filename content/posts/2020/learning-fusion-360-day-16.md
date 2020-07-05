---
title: "Learning Fusion 360 in 30 Days - Day 16"
date: 2020-07-06
tags: ["cad", "fusion-360", "autodesk", "challenges", "30-day-challenge", "fusion-360-in-30"]
draft: true
---
### Project
Sketch constraints

### Lessons Learned
- Constraints allow relating of one entity to another entity
- Provide predictability when sketches change
- With properly constrained and dimensions you know exactly what will happen when you alter the sketch dimensions
- Constraints can be used in conjunction to be used more efficiently
- Right clicking on an entity when in sketch mode will show the relevant constraints
    - Can also do this with multiple selection
- Fully constrained sketched turn sketches black

{{% table %}}
| Constraint            | Description                                                                   | Important Notes                                            |
|-----------------------|-------------------------------------------------------------------------------|------------------------------------------------------------|
| Coincident            | Ensures entities 'coincide'                                                   | Can only be used on a points and lines | 
| Colinear              | Forces two lines to share the same axis                                       | Order of selection matters - the first line stays in place, the other moves to satisfy the constraint | 
| Concentric            | Forces two entities to share the same centre point                            | Entity must actually have a centre point | 
| Midpoint              | Forces the endpoint of a line to the centre point of a line or arc            || 
| Fix/unfix             | Prevents changes to the entity. Turns entities green when applied (when they are fixed) | Endpoints can still be adjusted. Use not recommended | 
| Parallel              | Forces to lines to be parallel. It's in the name                              || 
| Perpendicular         | Forces two lines to be perpendicular                                          | Lines don't have to be touching | 
| Vertical/Horizontal   | Forces two lines to be horizontal/vertical, or two points to be on the same vertical/horizontal line | Chooses whichever is the 'nearest', i.e., a 5 degree off vertical would go vertical, but a 65 degree off vertical one would go horizontral. Can be used to line up points with one another too | 
| Tangent               | Forces a line to become tangent with a circular entity                        | Useful for creating smooth curves | 
| Curvature             | Makes curvature at a transition point equal                                   | Helps to make organic shapes smoother  | 
| Equal                 | Forces two entities to be equal in size                                       || 
| Symmetry              | Makes entities symmetrical                                                    | Requires three clicks - the first two are the entities, and the third is what they are symmetrical about, either another entity or an axis of symmetry  | 
{{% table %}}

### Completed Project
None
