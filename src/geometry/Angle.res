/*
 ReScript Module: Angle
 */

open Point

let toDegrees = a => {
  a *. 180. /. Js.Math._PI
}

let toRadians = a => {
  a *. Js.Math._PI /. 180.
}

let diff = (~a1: float, ~a2: float) => {
  let delA = ref(0.)
  if a1 < a2 {
    delA := a2 -. a1
  } else {
    delA := a1 -. a2
  }

  if delA.contents > Js.Math._PI {
    delA := 2. *. Js.Math._PI -. delA.contents
  }
}

let normalize = angle => {
  let n = ref(angle)
  while n.contents > Js.Math._PI {
    n := n.contents -. 2. *. Js.Math._PI
  }
  while n.contents <= -1. *. Js.Math._PI {
    n := n.contents +. 2. *. Js.Math._PI
  }
  n.contents
}

let normalizePositive = angle => {
  let n = ref(angle)
  if n.contents < 0.0 {
    while n.contents < 0.0 {
      n := n.contents +. 2. *. Js.Math._PI
    }

    // in case round-off error bumps the value over
    if n.contents >= 2.0 *. Js.Math._PI {
      n := 0.0
    }
  } else {
    while n.contents >= 2.0 *. Js.Math._PI {
      n := n.contents -. 2. *. Js.Math._PI
    }
    if n.contents < 0.0 {
      n.contents = 0.0
    }
  }
  n.contents
}

let angle = (~p1: point, ~p2: point) => {
  let dx = p2.x -. p1.x
  let dy = p2.y -. p1.y
  Js.Math.atan2(~y=dy, ~x=dx, ())
}

let isAcute = (~p0: point, ~p1: point, ~p2: point) => {
  let dx0 = p0.x -. p1.x
  let dy0 = p0.y -. p1.y
  let dx1 = p2.x -. p1.x
  let dy1 = p2.y -. p1.y
  let c = dx0 *. dy1 -. dx1 *. dy0
  c > 0.
}

let isObtuse = (~p0: point, ~p1: point, ~p2: point) => {
  let dx0 = p0.x -. p1.x
  let dy0 = p0.y -. p1.y
  let dx1 = p2.x -. p1.x
  let dy1 = p2.y -. p1.y
  let c = dx0 *. dy1 -. dx1 *. dy0
  c < 0.
}

let angleBetween = (~p1: point, ~p2: point, ~p3: point) => {
  let a1 = angle(~p1, ~p2)
  let a2 = angle(~p1, ~p2=p3)

  diff(~a1, ~a2)
}

let angleBetweenOriented = (~p1: point, ~p2: point, ~p3: point) => {
  let a1 = angle(~p1, ~p2)
  let a2 = angle(~p1, ~p2=p3)
  let angDel = a2 -. a1

  // normalize, maintaining orientation
  if angDel <= -1. *. Js.Math._PI {
    angDel +. 2. *. Js.Math._PI
  } else if angDel > Js.Math._PI {
    angDel -. 2. *. Js.Math._PI
  } else {
    angDel
  }
}
