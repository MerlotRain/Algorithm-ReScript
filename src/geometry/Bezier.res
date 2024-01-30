open Point
open Line

type bezier = {
  mutable p1: point,
  mutable p2: point,
  mutable p3: point,
  mutable p4: point,
}

let midPoint = (bz: bezier) => {
  {
    x: (bz.p1.x +. bz.p4.x +. 3. *. (bz.p2.x +. bz.p3.x)) /. 8.,
    y: (bz.p1.y +. bz.p4.y +. 3. *. (bz.p2.y +. bz.p3.y)) /. 8.,
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

let normalVector = (bz: bezier, t: float) => {
  let m_t = 1. -. t
  let a = m_t *. m_t
  let b = t *. m_t
  let c = t *. t
  {
    x: (bz.p2.y -. bz.p1.y) *. a +. (bz.p3.y -. bz.p2.y) *. b +. (bz.p4.y -. bz.p3.y) *. c,
    y: (bz.p1.x -. bz.p2.x) *. a +. (bz.p2.x -. bz.p3.x) *. b +. (bz.p3.x -. bz.p4.x) *. c,
  }
}

let split = (bz: bezier) => {
  let _mid = (lhs: point, rhs: point) => {{x: (lhs.x +. rhs.x) *. 0.5, y: (lhs.y +. rhs.y) *. 0.5}}
  let mid_12 = _mid(bz.p1, bz.p2)
  let mid_23 = _mid(bz.p2, bz.p3)
  let mid_34 = _mid(bz.p3, bz.p4)
  let mid_12_23 = _mid(mid_12, mid_23)
  let mid_23_34 = _mid(mid_23, mid_34)
  let mid_12_23__23_34 = _mid(mid_12_23, mid_23_34)
  list{
    {
      p1: bz.p1,
      p2: mid_12,
      p3: mid_12_23,
      p4: mid_12_23__23_34,
    },
    {
      p1: mid_12_23__23_34,
      p2: mid_23_34,
      p3: mid_34,
      p4: bz.p4,
    },
  }
}
