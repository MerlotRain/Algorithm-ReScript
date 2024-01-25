/*
 * ReScript module: Shape_Point
 *
 */

/*
 * A point in 2D space
 */
type point = {
  x: float,
  y: float,
}

/*
 * Calculate the distance between two points
 */
let distance: (point, point) => float

/*
 * Convert a point to a string
 */
let toString: point => string

/*
 * Check if two points are equal
 */
let equal: (point, point) => bool
