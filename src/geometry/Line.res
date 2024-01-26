open Point

type line = {
  begin: point,
  end: point,
}

let length = l => {
  let dx = l.end.x -. l.begin.x
  let dy = l.end.y -. l.begin.y
  Js.Math.sqrt(dx *. dx +. dy *. dy)
}
