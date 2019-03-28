class Enemy extends ParticleSystem {

  /*fields*/
  Vector2D origin = new Vector2D(random(width), 0); //the position that all the particles come from
  Vector2D velocity = new Vector2D(0, random(2, 3));
  float size = random(10, 25);
  float bulletSpeed = 5;
  float hp = 10;
  color c1 = color(255, 165, 0);

  /*constructors*/
  //default
  public Enemy() {
  }

  void show() {
    pushMatrix();
    translate(origin.x, origin.y);

    //calculate new mouse coordinates
    float mX = mouseX - origin.x;
    float mY = mouseY - origin.y;

    //calculate the angle of rotation based on mouse position AKA ship position
    float a = atan2(mY, mX); //returns values from -PI to PI
    a += PI/2; //add PI/2 to offset the range that atan2 returns

    //rotate by the angle
    rotate(a);

    noStroke();
    fill(c1); //changes color of ship if hit
    triangle(-this.size, this.size, 0, -this.size, this.size, this.size);

    //hitbox of enemy
      //fill(255);
      //rectMode(CENTER);
      //rect(0, 0, this.size, 2*this.size);

    popMatrix();
  }

  void move() {
    origin.add(velocity);
  }

  void run() {
    if (frameCount %20 ==0)
      this.addParticle();
      
    super.run();
  }
  void addParticle() {
    //calculate new mouse coordinates
    float mX = mouseX - origin.x;
    float mY = mouseY - origin.y;
    Vector2D direction = new Vector2D(mX, mY); //make a directional vector towards the top of the screen

    direction.norm(); //normalize the direction

    direction.mult(bulletSpeed);  //multiply it by the bullet speed

    //shoot a bullet in that direction. Adding bullets to the particle arrayList is possible because bullets ARE particles
    particles.add(new Bullet(origin, direction, new Vector2D(0, 0), color(255, 165, 0)));
  }

  boolean isDead() {
    return origin.y > height || hp == 0;
  }

  //stolen from Jeff Thompson
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
