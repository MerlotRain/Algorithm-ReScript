type point = {
  x: float,
  y: float,
}

let distance = (p1, p2) => {
  let dx = p1.x -. p2.x
  let dy = p1.y -. p2.y
  Js.Math.sqrt(dx *. dx +. dy *. dy)
}

let toString = p => {
  `(${Belt.Float.toString(p.x)}, ${Belt.Float.toString(p.x)})`
}

let equal = (p1, p2) => {
  p1.x == p2.x && p1.y == p2.y
}
