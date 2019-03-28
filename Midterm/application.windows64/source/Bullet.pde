
class Bullet extends Particle {
  /*fields are all inherited from Particle*/
  float radius = 7; //overwrite the radius field
  color outline = color(255);

  /*constructors*/
  //bullet constructor that lets us specify position, velocity, acceleration, and outline color
  //partially makes use of the super constructor in the Particle class
  public Bullet(Vector2D pos, Vector2D vel, Vector2D acc, color c1) {
    super(pos); //call the Particle constructor to avoid code duplication
    this.velocity.x = vel.x;
    this.velocity.y = vel.y;
    this.acceleration.x = acc.x;
    this.acceleration.y = acc.y;
    this.outline = c1;
  }

  /*methods are all inherited from Particle*/

  //override method to show the bullet
  public void show() {
    strokeWeight(3);
    stroke(outline); //outline color changes depedning if shot by enemy or user
    fill(255);
    ellipse(position.x, position.y, this.radius, this.radius);
  }

  boolean isDead() {
    return position.y < 0;
  }
}
