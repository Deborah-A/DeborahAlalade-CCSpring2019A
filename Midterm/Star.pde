class Star extends Particle {

  /*fields*/
  public Vector2D position = new Vector2D(random(width), 0);
  public Vector2D velocity = new Vector2D(0, random(4, 6));

  /*constructors*/
  //default
  public Star() {} 

  /*methods*/
  void show() {
    noStroke();
    fill(100);
    rect(position.x, position.y, (velocity.y)*.5, (velocity.y)*.5);
  }

  //method to move the particle
  void move() {
    position.add(velocity);
  }

  //method to check whether the particle is dead
  boolean isDead() {
    return (position.y > height);
  }
  
}
