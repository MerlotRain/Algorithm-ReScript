open Point

type line = {
  mutable begin: point,
  mutable end: point,
}

let length = l => {
  let dx = l.end.x -. l.begin.x
  let dy = l.end.y -. l.begin.y
  Js.Math.sqrt(dx *. dx +. dy *. dy)
}

let dx = l => {
  l.end.x -. l.begin.x
}

let dy = l => {
  l.end.y -. l.begin.y
}
