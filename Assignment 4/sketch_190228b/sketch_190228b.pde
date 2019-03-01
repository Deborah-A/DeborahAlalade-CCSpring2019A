/*Deborah Alalade SP19
  Assignment 4:
  Creating a sketch that makes use of transformations to create repetitive, 
  harmonic motion. Try to incorporate what we learned about color theory.
*/

//global variables
int i = 20; //the holy number i: 
            //counter for the number of squares, scale factor, decrement factor for color

void setup()
{
  size(1000, 1000);
  background(0);
  rectMode(CENTER);
  stroke(0);
  
  colorMode(HSB, 360, 100, 100);
}

void draw()
{
  color fillColor = color(360 - (10*i), 100, 100); //fill color that decrements by a factor of 20 times i to make a sort of spectrum 
  
  //an animation of concentric squares that goes from largest to smallest and thru 360 to 160? of the HSB color wheel
  if(frameCount%30 == 0 && i > 0) //times the creation of each square and avoids dividing by zero
  {
    pushMatrix(); //start a set of transformations
      scale(i); //scales the canvas by a scale of i
      translate(width/i, height/i); //basically translates it to the bottom right corner
      fill(fillColor); //changes color of concentric squares
      rect(0, 0, 100, 100); //draws square
    popMatrix(); //discard all transformations
    i--; //decrements to make a smaller square when it loops again into the if statement
  }
  
  //saveFrame();
}
