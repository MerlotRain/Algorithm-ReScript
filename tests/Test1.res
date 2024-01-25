open Shape.Point

let p1 = {
  x: 1.,
  y: 1.,
}

let p2 = {
  x: 0.,
  y: 0.,
}

let v = Js.log(Shape.Point.distance(p1, p2))
