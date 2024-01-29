open Point
open Line

type bezier = {
  mutable p1: point,
  mutable p2: point,
  mutable p3: point,
  mutable p4: point,
}

let midPoint = (_b: bezier) => {
  {
    x: (_b.p1.x +. _b.p4.x +. 3. *. (_b.p2.x +. _b.p3.x)) /. 8.,
    y: (_b.p1.y +. _b.p4.y +. 3. *. (_b.p2.y +. _b.p3.y)) /. 8.,
  }
}

let midTangent = (b: bezier) => {
  let mid = midPoint(b)
  let dir = {
    begin: {
      x: (b.p1.x +. b.p2.x) /. 2.,
      y: (b.p1.y +. b.p2.y) /. 2.,
    },
    end: {
      x: (b.p3.x +. b.p4.x) /. 2.,
      y: (b.p3.y +. b.p4.y) /. 2.,
    },
  }

  {
    begin: {
      x: mid.x -. Line.dx(dir),
      y: mid.y -. Line.dy(dir),
    },
    end: {
      x: mid.x +. Line.dx(dir),
      y: mid.y +. Line.dy(dir),
    },
  }
}

let pointAt = (bz: bezier, t: float) => {
  let x = ref(0.)
  let y = ref(0.)

  let m_t = 1. -. t

  {
    let a = ref(bz.p1.x *. m_t +. bz.p2.x *. t)
    let b = ref(bz.p2.x *. m_t +. bz.p3.x *. t)
    let c = ref(bz.p3.x *. m_t +. bz.p4.x *. t)
    a := a.contents *. m_t +. b.contents *. t
    b := b.contents *. m_t +. c.contents *. t
    x := a.contents *. m_t +. b.contents *. t
  }

  let a = ref(bz.p1.y *. m_t +. bz.p2.y *. t)
  let b = ref(bz.p2.y *. m_t +. bz.p3.y *. t)
  let c = ref(bz.p3.y *. m_t +. bz.p3.y *. t)
  a := a.contents *. m_t +. b.contents *. t
  b := b.contents *. m_t +. c.contents *. t
  y := a.contents *. m_t +. b.contents *. t

  {
    x: x.contents,
    y: y.contents,
  }
}
