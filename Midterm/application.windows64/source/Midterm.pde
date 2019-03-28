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


void setup() {
  size(800, 800);
  background(0);

  fill(255);
  stroke(255);
  rectMode(CENTER);

  ship = new Gunship(); 
  stars = new ArrayList<Star>();
  enemies = new ArrayList<Enemy>();
  obstacles = new ArrayList<Obstacle>();
}

void draw() {
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

void time(){
  textSize(20);
  text("Time: " + millis()/1000, 700, 50);
}


//shows stars in the background
void stars() {
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

void obstacles() {
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
void hit() {
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
void spawnEnemies() {
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
void healthDisplay() {
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
