type md5Context = {
  buffer: Belt.Array.t<int>,
  bytes: Belt.Array.t<int>,
  input: Belt.Array.t<int>,
}

let _A = 0x67452301
let _B = 0xefcdab89
let _C = 0x98badcfe
let _D = 0x10325476

let _S = [
  7,
  12,
  17,
  22,
  7,
  12,
  17,
  22,
  7,
  12,
  17,
  22,
  7,
  12,
  17,
  22,
  5,
  9,
  14,
  20,
  5,
  9,
  14,
  20,
  5,
  9,
  14,
  20,
  5,
  9,
  14,
  20,
  4,
  11,
  16,
  23,
  4,
  11,
  16,
  23,
  4,
  11,
  16,
  23,
  4,
  11,
  16,
  23,
  6,
  10,
  15,
  21,
  6,
  10,
  15,
  21,
  6,
  10,
  15,
  21,
  6,
  10,
  15,
  21,
]

let _PADDING = [
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
]

let _F1 = (x: int, y: int, z: int) => lor(land(x, y), land(lnot(x), z))
let _F2 = (x: int, y: int, z: int) => lor(land(x, z), land(y, lnot(z)))
let _F3 = (x: int, y: int, z: int) => lxor(lxor(x, y), z)
let _F4 = (x: int, y: int, z: int) => lxor(y, lor(x, lnot(z)))

let _MD5STEP = (f: (int, int, int) => int, w: int, x: int, y: int, z: int, i: int, s: int) => {
  let lw = ref(w)
  lw := w + f(x, y, z) + i
  lw := lor(lsl(lw.contents, s), lsr(w, 32 - s)) + x
  lw.contents
}

let rotateLeft = (x: int32, n: int32) => {
  lor(lsl(x, n), lsr(x, 32 - n))
}

let md5Transform = (buf: Belt.Array.t<int>, input: Belt.Array.t<int>) => {
  let a = ref(buf->Array.getUnsafe(0))
  let b = ref(buf->Array.getUnsafe(1))
  let c = ref(buf->Array.getUnsafe(2))
  let d = ref(buf->Array.getUnsafe(3))

  a :=
    _MD5STEP(
      _F1,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(0) + 0xd76aa478,
      7,
    )
  d :=
    _MD5STEP(
      _F1,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(1) + 0xe8c7b756,
      12,
    )
  c :=
    _MD5STEP(
      _F1,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(2) + 0x242070db,
      17,
    )
  b :=
    _MD5STEP(
      _F1,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(3) + 0xc1bdceee,
      22,
    )
  a :=
    _MD5STEP(
      _F1,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(4) + 0xf57c0faf,
      7,
    )
  d :=
    _MD5STEP(
      _F1,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(5) + 0x4787c62a,
      12,
    )
  c :=
    _MD5STEP(
      _F1,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(6) + 0xa8304613,
      17,
    )
  b :=
    _MD5STEP(
      _F1,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(7) + 0xfd469501,
      22,
    )
  a :=
    _MD5STEP(
      _F1,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(8) + 0x698098d8,
      7,
    )
  d :=
    _MD5STEP(
      _F1,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(9) + 0x8b44f7af,
      12,
    )
  c :=
    _MD5STEP(
      _F1,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(10) + 0xffff5bb1,
      17,
    )
  b :=
    _MD5STEP(
      _F1,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(11) + 0x895cd7be,
      22,
    )
  a :=
    _MD5STEP(
      _F1,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(12) + 0x6b901122,
      7,
    )
  d :=
    _MD5STEP(
      _F1,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(13) + 0xfd987193,
      12,
    )
  c :=
    _MD5STEP(
      _F1,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(14) + 0xa679438e,
      17,
    )
  b :=
    _MD5STEP(
      _F1,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(15) + 0x49b40821,
      22,
    )

  a :=
    _MD5STEP(
      _F2,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(1) + 0xf61e2562,
      5,
    )
  d :=
    _MD5STEP(
      _F2,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(6) + 0xc040b340,
      9,
    )
  c :=
    _MD5STEP(
      _F2,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(11) + 0x265e5a51,
      14,
    )
  b :=
    _MD5STEP(
      _F2,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(0) + 0xe9b6c7aa,
      20,
    )
  a :=
    _MD5STEP(
      _F2,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(5) + 0xd62f105d,
      5,
    )
  d :=
    _MD5STEP(
      _F2,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(10) + 0x02441453,
      9,
    )
  c :=
    _MD5STEP(
      _F2,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(15) + 0xd8a1e681,
      14,
    )
  b :=
    _MD5STEP(
      _F2,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(4) + 0xe7d3fbc8,
      20,
    )
  a :=
    _MD5STEP(
      _F2,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(9) + 0x21e1cde6,
      5,
    )
  d :=
    _MD5STEP(
      _F2,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(14) + 0xc33707d6,
      9,
    )
  c :=
    _MD5STEP(
      _F2,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(3) + 0xf4d50d87,
      14,
    )
  b :=
    _MD5STEP(
      _F2,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(8) + 0x455a14ed,
      20,
    )
  a :=
    _MD5STEP(
      _F2,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(13) + 0xa9e3e905,
      5,
    )
  d :=
    _MD5STEP(
      _F2,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(2) + 0xfcefa3f8,
      9,
    )
  c :=
    _MD5STEP(
      _F2,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(7) + 0x676f02d9,
      14,
    )
  b :=
    _MD5STEP(
      _F2,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(12) + 0x8d2a4c8a,
      20,
    )

  a :=
    _MD5STEP(
      _F3,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(5) + 0xfffa3942,
      4,
    )
  d :=
    _MD5STEP(
      _F3,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(8) + 0x8771f681,
      11,
    )
  c :=
    _MD5STEP(
      _F3,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(11) + 0x6d9d6122,
      16,
    )
  b :=
    _MD5STEP(
      _F3,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(14) + 0xfde5380c,
      23,
    )
  a :=
    _MD5STEP(
      _F3,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(1) + 0xa4beea44,
      4,
    )
  d :=
    _MD5STEP(
      _F3,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(4) + 0x4bdecfa9,
      11,
    )
  c :=
    _MD5STEP(
      _F3,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(7) + 0xf6bb4b60,
      16,
    )
  b :=
    _MD5STEP(
      _F3,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(10) + 0xbebfbc70,
      23,
    )
  a :=
    _MD5STEP(
      _F3,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(13) + 0x289b7ec6,
      4,
    )
  d :=
    _MD5STEP(
      _F3,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(0) + 0xeaa127fa,
      11,
    )
  c :=
    _MD5STEP(
      _F3,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(3) + 0xd4ef3085,
      16,
    )
  b :=
    _MD5STEP(
      _F3,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(6) + 0x04881d05,
      23,
    )
  a :=
    _MD5STEP(
      _F3,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(9) + 0xd9d4d039,
      4,
    )
  d :=
    _MD5STEP(
      _F3,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(12) + 0xe6db99e5,
      11,
    )
  c :=
    _MD5STEP(
      _F3,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(15) + 0x1fa27cf8,
      16,
    )
  b :=
    _MD5STEP(
      _F3,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(2) + 0xc4ac5665,
      23,
    )

  a :=
    _MD5STEP(
      _F4,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(0) + 0xf4292244,
      6,
    )
  d :=
    _MD5STEP(
      _F4,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(7) + 0x432aff97,
      10,
    )
  c :=
    _MD5STEP(
      _F4,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(14) + 0xab9423a7,
      15,
    )
  b :=
    _MD5STEP(
      _F4,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(5) + 0xfc93a039,
      21,
    )
  a :=
    _MD5STEP(
      _F4,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(12) + 0x655b59c3,
      6,
    )
  d :=
    _MD5STEP(
      _F4,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(3) + 0x8f0ccc92,
      10,
    )
  c :=
    _MD5STEP(
      _F4,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(10) + 0xffeff47d,
      15,
    )
  b :=
    _MD5STEP(
      _F4,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(1) + 0x85845dd1,
      21,
    )
  a :=
    _MD5STEP(
      _F4,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(8) + 0x6fa87e4f,
      6,
    )
  d :=
    _MD5STEP(
      _F4,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(15) + 0xfe2ce6e0,
      10,
    )
  c :=
    _MD5STEP(
      _F4,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(6) + 0xa3014314,
      15,
    )
  b :=
    _MD5STEP(
      _F4,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(13) + 0x4e0811a1,
      21,
    )
  a :=
    _MD5STEP(
      _F4,
      a.contents,
      b.contents,
      c.contents,
      d.contents,
      input->Array.getUnsafe(4) + 0xf7537e82,
      6,
    )
  d :=
    _MD5STEP(
      _F4,
      d.contents,
      a.contents,
      b.contents,
      c.contents,
      input->Array.getUnsafe(11) + 0xbd3af235,
      10,
    )
  c :=
    _MD5STEP(
      _F4,
      c.contents,
      d.contents,
      a.contents,
      b.contents,
      input->Array.getUnsafe(2) + 0x2ad7d2bb,
      15,
    )
  b :=
    _MD5STEP(
      _F4,
      b.contents,
      c.contents,
      d.contents,
      a.contents,
      input->Array.getUnsafe(9) + 0xeb86d391,
      21,
    )

  list{
    buf->Array.getUnsafe(0) + a.contents,
    buf->Array.getUnsafe(1) + b.contents,
    buf->Array.getUnsafe(2) + c.contents,
    buf->Array.getUnsafe(3) + d.contents,
  }
}
