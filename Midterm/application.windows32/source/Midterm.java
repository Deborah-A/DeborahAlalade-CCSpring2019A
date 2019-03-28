import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Midterm extends PApplet {

/* Author: Deborah Alalade
 Description: A simple bulllet hell game where the user can move using the mouse and shoot by holding it down
 */

Gunship ship; //user's ship
ArrayList <Star> stars; //array of stars for background
ArrayList <Enemy> enemies; //array of enemies
ArrayList <Obstacle> obstacles; //array of obstacles

int myHP = 10; //user's hp
float invincibility = 500; //amount of millis user is invincible
float colorT = 100; //amount of time the enemy is red
boolean hit ; //boolean to check if user was hit or not
float eTime; //to store time for when enemy is hit to change colors
float iTime; //to store time for when user is hit to give invincibility
float sTime; //survival time


public void setup() {
  
  background(0);

  fill(255);
  stroke(255);
  rectMode(CENTER);

  ship = new Gunship(); 
  stars = new ArrayList<Star>();
  enemies = new ArrayList<Enemy>();
  obstacles = new ArrayList<Obstacle>();
}

public void draw() {
  background(0); //refresh bg

  stars(); //adds stars to background

  ship.origin = new Vector2D(mouseX, mouseY); //moves ship to mouse position
  ship.show(); //show the player ship
  ship.run(); //run the player's bullets

  if (frameCount % 120 == 0) //adds an enemy every 2 seconds to the arrayList
    enemies.add(new Enemy());
  spawnEnemies(); //shows and runs the enemy

  //if user is hit, they can't get hit again until 500 millis later
  if (hit) {
    if (millis() > iTime+invincibility) {
      hit = false;
    }
  } else {
    hit(); //checks if user was hit by enemy bullet
  }
  
  obstacles(); //runs obstacle

  //user shoots bullets when holding down mouse key
  if (mousePressed && frameCount%5 == 0) 
    ship.addParticle(); 

  time();
  healthDisplay();
  if(myHP >0)
    sTime = millis(); //stores time user's been playing
  //println(stars.size());
}

public void time(){
  textSize(20);
  text("Time: " + millis()/1000, 700, 50);
}


//shows stars in the background
public void stars() {
  stars.add(new Star()); //adds a star

  for (int i = stars.size()-1; i >=0; i--) //runs thru the array to move each individual star
  {
    Star star = stars.get(i);
    star.show(); //shows star
    star.move(); //moves star
    if (star.isDead()) //removes star when off screen
      stars.remove(i);
  }
}

public void obstacles() {
  if (myHP != 0) { //makes sure its not divding by zero
    if (frameCount%(60*myHP) == 0) //frequency of obstacles increases as user health decreases
      obstacles.add(new Obstacle()); //adds an obstacle
  } else
    obstacles.add(new Obstacle()); //adds an obstacle

  //moves thru array to move each obstacle
  for (int i = obstacles.size()-1; i >=0; i--)
  {
    Obstacle ob = obstacles.get(i);
    ob.show(); //shows obstacle
    ob.move(); //moves obstacle down screen
    if (ob.isDead()) //removes obstacle when it's off screen
      obstacles.remove(i);

    //insta kills user if they hit an obstacle
    if (ship.collision(ob.position.x -50, ob.position.y-50, ob.size, ob.size, ship.origin.x, ship.origin.y, ship.size, ship.size)) {
      myHP =0;
    }
  }
}

//checks if the enemy bullet hits the ships hitbox and if so decrements myHP and removes that individual bullet
public void hit() {
  for (int i = enemies.size()-1; i >=0; i--)
  {
    Enemy e = enemies.get(i);
    for (int j = e.particles.size()-1; j>=0; j--) {
      if (ship.collision(e.particles.get(j).position.x, e.particles.get(j).position.y, e.particles.get(j).radius, e.particles.get(j).radius, ship.origin.x, ship.origin.y, ship.size, ship.size)) {
        e.particles.remove(j); //removes enemy's hitting bullet
        myHP--; //decreases user's hp
        hit = true; //stores info if user was hit or not
        iTime = millis(); //saves time when user was hit
      }
    }
  }
}

//spawns enemies and checks if user's bullets hits the enemies hitbox and remove the bullet that hit
public void spawnEnemies() {
  //goes thru array of enemies to show, move, and shoot
  for (int i = enemies.size()-1; i >=0; i--) {
    Enemy e = enemies.get(i);
    e.show(); //shows the enemy
    e.move(); //moves it down the screen
    e.run(); //enemy can shoot
    
    //checks if the user's bullet hits enemy hitbox decrement enemey's hp and remove bullet
    for (int j = ship.particles.size()-1; j>=0; j--) {
      if (e.collision(ship.particles.get(j).position.x, ship.particles.get(j).position.y, ship.particles.get(j).radius, ship.particles.get(j).radius, e.origin.x, e.origin.y, 2*e.size, 2*e.size)) {
        ship.particles.remove(j); //removes hitting bullet
        e.c1 = color(255, 0, 0); //changes enemy's color to red
        e.hp--; //decreases enemy's hp
        eTime = millis(); //stores time when enemy is hit
      }
    }
    
    if (millis() > eTime+colorT) //if enemy is hit, changes back to og color after 100 millis
      e.c1 = color(255, 165, 0);
      
    if (e.isDead()) //removes ded enemy
      enemies.remove(i);
  }
}


//displays remaining health as circles
public void healthDisplay() {
  fill(255, 0, 0);
  noStroke();
  if (myHP == 10) { //10 circles for 10 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
    circle(300+50, 50, 50);
    circle(350+60, 50, 50);
    circle(400+70, 50, 50);
    circle(450+80, 50, 50);
    circle(500+90, 50, 50);
  } else if (myHP == 9) { //9 circles for 9 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
    circle(300+50, 50, 50);
    circle(350+60, 50, 50);
    circle(400+70, 50, 50);
    circle(450+80, 50, 50);
  } else if (myHP == 8) { //8 circles for 8 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
    circle(300+50, 50, 50);
    circle(350+60, 50, 50);
    circle(400+70, 50, 50);
  } else if (myHP == 7) { //7 circles for 7 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
    circle(300+50, 50, 50);
    circle(350+60, 50, 50);
  } else if (myHP == 6) { //6 circles for 3+3 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
    circle(300+50, 50, 50);
  } else if (myHP == 5) { //5 circles for 5 health
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
    circle(250+40, 50, 50);
  } else if (myHP == 4) { //4 circles for 4 hp
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
    circle(200+30, 50, 50);
  } else if (myHP == 3) { //3 circles for 3 life
    circle(50, 50, 50);
    circle(100+10, 50, 50);
    circle(150+20, 50, 50);
  } else if (myHP == 2) { //2 circles for two close for death
    circle(50, 50, 50);
    circle(100+10, 50, 50);
  } else if (myHP == 1) { //1 circle for 1 circle
    circle(50, 50, 50);
  } else {               //dead
    background(0);
    textSize(50);
    text("GAME OVER", width/2 - 150, height/2);
    fill(255);
    textSize(25);
    text("Survived " + sTime/1000 + " seconds", width/2 - 150, height/2 +50);
  }
}


class Bullet extends Particle {
  /*fields are all inherited from Particle*/
  float radius = 7; //overwrite the radius field
  int outline = color(255);

  /*constructors*/
  //bullet constructor that lets us specify position, velocity, acceleration, and outline color
  //partially makes use of the super constructor in the Particle class
  public Bullet(Vector2D pos, Vector2D vel, Vector2D acc, int c1) {
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

  public boolean isDead() {
    return position.y < 0;
  }
}
class Enemy extends ParticleSystem {

  /*fields*/
  Vector2D origin = new Vector2D(random(width), 0); //the position that all the particles come from
  Vector2D velocity = new Vector2D(0, random(2, 3));
  float size = random(10, 25);
  float bulletSpeed = 5;
  float hp = 10;
  int c1 = color(255, 165, 0);

  /*constructors*/
  //default
  public Enemy() {
  }

  public void show() {
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

  public void move() {
    origin.add(velocity);
  }

  public void run() {
    if (frameCount %20 ==0)
      this.addParticle();
      
    super.run();
  }
  public void addParticle() {
    //calculate new mouse coordinates
    float mX = mouseX - origin.x;
    float mY = mouseY - origin.y;
    Vector2D direction = new Vector2D(mX, mY); //make a directional vector towards the top of the screen

    direction.norm(); //normalize the direction

    direction.mult(bulletSpeed);  //multiply it by the bullet speed

    //shoot a bullet in that direction. Adding bullets to the particle arrayList is possible because bullets ARE particles
    particles.add(new Bullet(origin, direction, new Vector2D(0, 0), color(255, 165, 0)));
  }

  public boolean isDead() {
    return origin.y > height || hp == 0;
  }

  //stolen from Jeff Thompson
  public boolean collision(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
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
  public void show() {
    pushMatrix();
    translate(origin.x, origin.y); //moves ship where the mouse is
    noStroke();
    fill(255);
    triangle(-this.size, this.size, 0, -this.size, this.size, this.size); //draw the triangle 
    popMatrix();
  }

  //method for the gunship to shoot. Adds bullet objects to the particle arraylist
  public void addParticle() {
    Vector2D direction = new Vector2D(0, -mouseY); //make a directional vector towards the top of the screen

    direction.norm(); //normalize the direction

    direction.mult(bulletSpeed);  //multiply it by the bullet speed

    //shoot a bullet in that direction. Adding bullets to the particle arrayList is possible because bullets ARE particles
    particles.add(new Bullet(origin, direction, new Vector2D(0, 0), color(80, 125, 255)));
  }


  //stolen from Jeff Thompson: www.jeffreythompson.org/collision-detection/rect-rect.php
  public boolean collision(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
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
class Obstacle extends Particle{
  /*fields*/
  public Vector2D position = new Vector2D(random(width), 0); //starting position of obstacle
  public Vector2D velocity = new Vector2D(0, 5); //velocity of obstacle
  public int size = 100; //size of obstacle

  /*constructors*/
  //default
  public Obstacle() {} 

  /*methods*/
  public void show() {
    noStroke();
    fill(100);
    rect(position.x, position.y, size, size);
  }

  //method to move the obstacle
  public void move() {
    position.add(velocity);
  }

  //method to check whether the particle is dead
  public boolean isDead() {
    return (position.y > height);
  }
  
  //stolen from Jeff Thompson: www.jeffreythompson.org/collision-detection/rect-rect.php
  public boolean collision(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
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
class Particle {

  /* fields */
  //position velocity acceleration of the particle
  public Vector2D position = new Vector2D(0, 0);
  public Vector2D velocity = new Vector2D(random(-1, 1), random(-1, 1));
  public Vector2D acceleration = new Vector2D(0, 0);

  public float radius = random(10, 50); //radius of the particles

  /* constructors: add new ones to customize your particle system */

  //blank constructor
  public Particle() {}

  //constructor that takes a position vector
  public Particle(Vector2D origin) {
    this.position.x = origin.x;
    this.position.y = origin.y;
  }

  //constructor that takes x, y
  public Particle(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }

  /* non-static methods */

  //method to move the particle
  public void move() {
    velocity.add(acceleration);
    position.add(velocity);
  }

  //method to draw the particle
  public void show() {
    stroke(255);
    fill(255);
    ellipse(position.x, position.y, this.radius, this.radius);
  }

  //method to check whether the particle is dead
  public boolean isDead() {
    return (position.y > height);
  }
}
class ParticleSystem {

  /* fields */
  ArrayList<Particle> particles = new ArrayList<Particle>(); //the particles of this system
  Vector2D origin = new Vector2D(0, 0); //the position that all the particles come from

  /* constructors */

  //blank constructor
  public ParticleSystem() {}

  //constructor that positions the particle system based on a vector argument
  public ParticleSystem(Vector2D o) {
    origin.x = o.x;
    origin.y = o.y;
  }

  //constructor that positions the particle system based on two floats
  public ParticleSystem(float x, float y) {
    origin.x = x;
    origin.y = y;
  }

  /* methods */

  //method to make each particle in the arraylist show and move itself, and then remove any dead particles (i.e. run the particle system)
  public void run() {
    //loop through the particle system
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i); //store the current particle
      p.show(); //show it
      p.move(); //move it

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  //method to add a particle into the particle system
  //can you change this method so that sketches can draw with particles?
  public void addParticle() {
    particles.add(new Particle(origin));
  }
}
class Star extends Particle {

  /*fields*/
  public Vector2D position = new Vector2D(random(width), 0);
  public Vector2D velocity = new Vector2D(0, random(4, 6));

  /*constructors*/
  //default
  public Star() {} 

  /*methods*/
  public void show() {
    noStroke();
    fill(100);
    rect(position.x, position.y, (velocity.y)*.5f, (velocity.y)*.5f);
  }

  //method to move the particle
  public void move() {
    position.add(velocity);
  }

  //method to check whether the particle is dead
  public boolean isDead() {
    return (position.y > height);
  }
  
}
static class Vector2D {
  /* fields */
  public float x = 0;
  public float y = 0;

  /* constructors */

  //blank constructor
  public Vector2D() {
  }

  //x,y constructor
  public Vector2D(float x, float y) {
    this.x = x;
    this.y = y;
  }

  /* non-static methods: usable only by objects of the class */

  //method to let a vector add another vector to itself
  public void add(Vector2D other) {
    this.x += other.x;
    this.y += other.y;
  }

  //method to let a vector subtract another vector from itself
  public void sub(Vector2D other) {
    this.x -= other.x;
    this.y -= other.y;
  }

  //method to let a vector multiply itself with a scalar
  public void mult(float scalar) {
    this.x *= scalar;
    this.y *= scalar;
  }

  //method to let a vector divide itself with a scalar
  public void div(float scalar) {
    this.x /= scalar;
    this.y /= scalar;
  }

  //method to let a vector return its magnitude
  public float mag() {
    float m = sqrt(pow(this.x, 2) + pow(this.y, 2));
    return m;
  }

  //method to let a vector normalize itself
  public void norm() {
    float mag = this.mag(); //calculate the magnitude of the vector
    Vector2D normal = new Vector2D(this.x/mag, this.y/mag); //divide it by its magnitude
    this.x = normal.x;
    this.y = normal.y;
  }

  /* static methods: usable without creating an object of the class, but also usable by objects of the class */

  //method that adds two vectors and returns the result as a third one
  public Vector2D add(Vector2D v1, Vector2D v2) {
    Vector2D result = new Vector2D(v1.x + v2.x, v1.y + v2.y);
    return result;
  }

  //method that subtracts two vectors (v2 from v1) and returns the result as a third one
  public Vector2D sub(Vector2D v1, Vector2D v2) {
    Vector2D result = new Vector2D(v1.x - v2.x, v1.y - v2.y);
    return result;
  }

  //method that multiplies a vector by a scalar
  public Vector2D mult(Vector2D v, float scalar) {
    Vector2D result = new Vector2D(v.x * scalar, v.y * scalar);
    return result;
  }

  public Vector2D div(Vector2D v, float scalar) {
    Vector2D result = new Vector2D(v.x/scalar, v.y/scalar);
    return result;
  }

  //method that returns the magnitude of a vector
  public float mag(Vector2D v) {
    float m = sqrt(pow(v.x, 2) + pow(v.y, 2));
    return m;
  }

  //method that returns the normalized vector of another vector v
  public Vector2D norm(Vector2D v) {
    float mag = v.mag(); //calculate the magnitude of the vector
    Vector2D normal = new Vector2D(v.x/mag, v.y/mag); //divide each component with the magnitude
    return normal; //return it
  }
}

  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Midterm" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
