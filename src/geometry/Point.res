type point = {
  mutable x: float,
  mutable y: float,
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

let project = (pt, distance, azimuth) => {
  let radsXY = azimuth *. Js.Math._PI /. 180.
  let dx = ref(0.)
  let dy = ref(0.)

  dx := distance *. Js.Math.sin(radsXY)
  dy := distance *. Js.Math.cos(radsXY)
  {
    x: pt.x +. dx.contents,
    y: pt.y +. dy.contents,
  }
}
