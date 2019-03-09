/*Author: Deborah Alalade
  Description: a sketch of two characters on a boat that bobs up and down
  */
   
float bob; //a variable to hold the wquation used to bob up and down

int xSpacing = 10;   //spacing between ellipses for wave
int w;              // Width of entire wave
float theta = 0.0;  // Start angle at 0
float dx;  // Value for incrementing X, a function of period and xSpacing
float[] yvalues;  //an array to store y values for the wave
  
void setup(){
  size(1280, 720);

  w = width + 150; 
  dx = (TWO_PI/500) * xSpacing; 
  yvalues = new float[w/xSpacing];
}


float xoff = 0; //beggining of xoffset

void draw(){
  bob= 10*sin(50*frameCount); //bob increases and decreases everytime frameCount increases
  background(125, 200, 250);
  drawChara(3*width/4, 3*height/10, .5);
  drawChara(2*width/3, height/4, .6);
  drawBoat();
  calcWave();
  drawWave();
}

//draws the character at a specific size on a specific xCoord & yCoord on the canvas
void drawChara(int xCoord, int yCoord, float scale){
    pushMatrix();
    translate(xCoord, yCoord+bob);
    scale(scale);
      //body
        stroke(0);
        strokeWeight(5);
        line(0,50, 0, 200);
        
      //face
        //head
        noStroke();
        fill(255);
        ellipse(0, 0, 100, 100);
        //eyes
        fill(0);
        ellipse(-25, -25, 10, 10);
        ellipse(25, -25, 10, 10);
        //smile
        noFill();
        stroke(0);
        strokeWeight(5);
        arc(0, 0, 75, 20, 0, PI); 
      
      //arms
        if(frameCount%60< 30)
          line(-75, 50, 75, 150);
        else
          line(-75, 150, 75, 50);
          
      //legs
        line(0, 200, -75, 300);
        line(0, 200, 75, 300);
    popMatrix();
}

//calculates a y value for each x value
void calcWave() {
  theta += .1;   
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 50*sin(x); //saves the y value in the array
    x+=dx;
  }
}

//draws the wave from calculated y values by making an ellipse at the yCoord for the given xCoord
void drawWave() {
  noStroke();
  fill(0, 100, 150);
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xSpacing, (height)+yvalues[x], 150, 150);
  }
}

//draws the boat
void drawBoat(){
  //the sail pole
  stroke(0);
  strokeWeight(10);
  line(width/2, height/2 +bob, width/2, -100+bob);
  
  //the sail
  noStroke();
  fill(255);
  triangle(width/2,  height/3 +bob, width/8,  height/3 +bob, width/2,  -100+bob);
  
  //the boat
  fill(150, 75, 25);
  arc(width/2, (height/2)+bob, 7*width/8, 3*height/2, 0, PI);  
}
