class RainDrop 
{
  //fields
  public Vector2D position = new Vector2D(random(-200, width), height/5);
  public Vector2D velocity = new Vector2D(2, random(3, 5));
  public float size = 3;
  public float lifespan = 100; //lifespan of the particle tied to its alpha value (transparency)
  
  //constructors
  public RainDrop(){}
  
  public RainDrop(Vector2D origin){
    this.position.x = origin.x;
    this.position.y = origin.y;
  }
  
  public RainDrop(Vector2D origin, int s){
    this.position.x = origin.x;
    this.position.y = origin.y;
    size = s;
  }
  
  //methods
  //moves rain drop
  void move(){
    position.add(velocity);
    lifespan -= 2.0; 
  }
  
  //method to draw the particle
  void show(){
    stroke(3, 74, 255, 100);
    fill(3, 74, 255, 100);
    circle(position.x, position.y, size);
  }
    
  //method to check whether the particle is dead
  boolean isDead(){
    return (lifespan < 0.0);
  }
}
  
