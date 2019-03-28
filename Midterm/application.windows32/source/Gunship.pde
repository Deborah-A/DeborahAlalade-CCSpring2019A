class Gunship extends ParticleSystem {
  float size = 10; //add a field for the size of the gunship
  float bulletSpeed = 10; //add a field for the speed of the bullets shot by the ship

  /*constructors*/
  //blank constructor
  public Gunship() {} 
  
  //constructor to place the Gunship at x,y 
  public Gunship(float x, float y) {
    origin.x = x;
    origin.y = y;
  }

  /*methods are completely inherited from ParticleSystem*/

  //a method for the gunship to show itself
  void show() {
    pushMatrix();
    translate(origin.x, origin.y); //moves ship where the mouse is
    noStroke();
    fill(255);
    triangle(-this.size, this.size, 0, -this.size, this.size, this.size); //draw the triangle 
    popMatrix();
  }

  //method for the gunship to shoot. Adds bullet objects to the particle arraylist
  void addParticle() {
    Vector2D direction = new Vector2D(0, -mouseY); //make a directional vector towards the top of the screen

    direction.norm(); //normalize the direction

    direction.mult(bulletSpeed);  //multiply it by the bullet speed

    //shoot a bullet in that direction. Adding bullets to the particle arrayList is possible because bullets ARE particles
    particles.add(new Bullet(origin, direction, new Vector2D(0, 0), color(80, 125, 255)));
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
