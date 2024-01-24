type rawPoint = {
  x: float,
  y: float,
}

let point_distance = (~p1: rawPoint, ~p2: rawPoint) => {
  let dx = p1.x -. p2.x
  let dy = p1.y -. p2.y
  Js.Math.sqrt(dx *. dx +. dy *. dy)
}


let point_equal = (~p1: rawPoint, ~p2: rawPoint) => {
  p1.x == p2.x && p1.y == p2.y
}