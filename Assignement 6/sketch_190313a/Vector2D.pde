static class Vector2D{
  /* fields */
  public float x = 0;
  public float y = 0;
  
  /* constructors */
  
  //blank constructor
  public Vector2D(){
    
  }
  
  //x,y constructor
  public Vector2D(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  /* non-static methods: usable only by objects of the class */
  
  //method to let a vector add another vector to itself
  public void add(Vector2D other){
    this.x += other.x;
    this.y += other.y;
  }
  
  //method to let a vector subtract another vector from itself
  public void sub(Vector2D other){
    this.x -= other.x;
    this.y -= other.y;
  }
  
  //method to let a vector multiply itself with a scalar
  public void mult(float scalar){
    this.x *= scalar;
    this.y *= scalar;
  }
  
  //method to let a vector devide itself with a scalar
  public void div(float scalar){
    this.x /= scalar;
    this.y /= scalar;
  }
  
  //method for a vecot to return its maginitude
  public float mag(){
    float result = sqrt(pow(x, 2) + pow(y, 2));
    return result;
  }
  
  //method for a vector to normalize itself
  public void norm(){
    //calc the magnitude
    float mag = sqrt(pow(this.x, 2) + pow(this.y, 2));
    this.x /= mag;
    this.y /= mag;
  }
  
  /* static methods: usable without creating an object of the class, but also usable by objects of the class */
  
  //method that adds two vectors and returns the result as a third one
  public Vector2D add(Vector2D v1, Vector2D v2){
    Vector2D result = new Vector2D(v1.x + v2.x, v1.y + v2.y);
    return result;
  }
  
  //method that subtracts two vectors (v2 from v1) and returns the result as a third one
  public Vector2D sub(Vector2D v1, Vector2D v2){
    Vector2D result = new Vector2D(v1.x - v2.x, v1.y - v2.y);
    return result;
  }
  
  //method that multiplies a vector by a scalar
  public Vector2D mult(Vector2D v, float scalar){
    Vector2D result = new Vector2D(v.x * scalar, v.y * scalar);
    return result;
  }
  
  //method that divides a vector by a scalar
  public Vector2D div(Vector2D v, float scalar){
    Vector2D result = new Vector2D(v.x / scalar, v.y / scalar);
    return result;
  }
}
