class Obstacle extends Particle{
  /*fields*/
  public Vector2D position = new Vector2D(random(width), 0); //starting position of obstacle
  public Vector2D velocity = new Vector2D(0, 5); //velocity of obstacle
  public int size = 100; //size of obstacle

  /*constructors*/
  //default
  public Obstacle() {} 

  /*methods*/
  void show() {
    noStroke();
    fill(100);
    rect(position.x, position.y, size, size);
  }

  //method to move the obstacle
  void move() {
    position.add(velocity);
  }

  //method to check whether the particle is dead
  boolean isDead() {
    return (position.y > height);
  }
  
  //stolen from Jeff Thompson: www.jeffreythompson.org/collision-detection/rect-rect.php
  boolean collision(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
    // are the sides of one rectangle touching the other?

    if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
      return true;
    }
    return false;
  }
}
