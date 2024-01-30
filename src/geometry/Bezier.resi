open Point
open Line

type bezier = {
  mutable p1: point,
  mutable p2: point,
  mutable p3: point,
  mutable p4: point,
}

let midPoint: bezier => point

let midTangent: bezier => line

let pointAt: (bezier, float) => point

let normalVector: (bezier, float) => point

let split: bezier => list<bezier>
