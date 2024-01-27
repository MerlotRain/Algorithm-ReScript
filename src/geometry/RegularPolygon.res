open Point

type constructionOption = InscribedCircle | CircumscribedCircle

type regularPolygon = {
  center: point,
  first_vertex: point,
  sides: int,
  radius: float,
}

let make = (
  ~center: point,
  ~radius: float,
  ~azimuth: float,
  ~sides: int,
  ~constructionOption: constructionOption,
) => {
  if sides < 3 {
    Error("Invalid number of sides")
  } else {
    switch constructionOption {
    | InscribedCircle =>
      Ok({
        center,
        first_vertex: Point.project(center, radius, azimuth),
        sides,
        radius: Js.Math.abs_float(radius),
      })
    | CircumscribedCircle => {
        let mRadius =
          Js.Math.abs_float(radius) /. Js.Math.cos(Js.Math._PI /. Belt.Int.toFloat(sides))
        Ok({
          center,
          first_vertex: Point.project(center, mRadius, azimuth -. Js.Math._PI /. 2.),
          sides,
          radius: mRadius,
        })
      }
    }
  }
}

let area = (~regular: regularPolygon) => {
  regular.radius *.
  regular.radius *.
  Belt.Int.toFloat(regular.sides) *.
  Js.Math.sin(360. /. Belt.Int.toFloat(regular.sides) *. Js.Math._PI /. 180.) /. 2.
}

let length = (~regular: regularPolygon) => {
  regular.radius *. 2. *. Js.Math.sin(Js.Math._PI /. Belt.Int.toFloat(regular.sides))
}

let perimeter = (~regular: regularPolygon) => {
  length(~regular) *. Belt.Int.toFloat(regular.sides)
}
