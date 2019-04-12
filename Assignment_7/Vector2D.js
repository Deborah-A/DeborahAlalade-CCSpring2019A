class Vector2D {
  /* constructor & fields */
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  /* non-static methods: usable only by objects of the class */

  //method to let a vector add another vector to itself
  add(other) {
    this.x += other.x;
    this.y += other.y;
  }

  //method to let a vector subtract another vector from itself
  sub(other) {
    this.x -= other.x;
    this.y -= other.y;
  }

  //method to let a vector multiply itself with a scalar
  mult(scalar) {
    this.x *= scalar;
    this.y *= scalar;
  }

  //method to let a vector devide itself with a scalar
  div(scalar) {
    this.x /= scalar;
    this.y /= scalar;
  }

  //method for a vecor to return its maginitude
  mag() {
    let result = Math.sqrt((this.x * this.x) + (this.y * this.y));
    return result;
  }

  //method for a vector to normalize itself
  norm() {
    //calc the magnitude
    var mag = Math.sqrt((this.x * this.x) + (this.y * this.y));
    this.x /= mag;
    this.y /= mag;
  }

  /* static methods: usable without creating an object of the class, but also usable by objects of the class */
/*
  //method that adds two vectors and returns the result as a third one
  static add(v1, v2) {
    let result = new Vector2D(v1.x + v2.x, v1.y + v2.y);
    return result;
  }

  //method that subtracts two vectors (v2 from v1) and returns the result as a third one
  static sub(v1, v2) {
    let result = new Vector2D(v1.x - v2.x, v1.y - v2.y);
    return result;
  }

  //method that multiplies a vector by a scalar
  static mult(v, scalar) {
    let result = new Vector2D(v.x * scalar, v.y * scalar);
    return result;
  }

  //method that divides a vector by a scalar
  static div(v, scalar) {
    let result = new Vector2D(v.x / scalar, v.y / scalar);
    return result;
  }
*/
}