open Geometry.Point
open Geometry.Line

let p1 = {
  x: 1.,
  y: 1.,
}

let p2 = {
  x: 0.,
  y: 0.,
}

let l = {
  begin: p1,
  end: p2,
}

Js.log(Geometry.Point.distance(p1, p2))

Js.log(Geometry.Line.length(l))