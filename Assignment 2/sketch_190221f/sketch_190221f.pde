//Deborah Alalade
//Assignment 2: Solving Sol
//Wall Drawing #17 (1969)
//Four-part drawing with a different line direction in each part. 

//variables
int spacing = 20; //the spacing between the lines
int colorRange = 255; //color range of RGB

void setup(){
  size(720, 720);
  background(255);
  
  //first section lines
  stroke(random(colorRange), random(colorRange), random(colorRange));
  for(int i = 0; i < width; i+=spacing){
    line(i, height/4, i+spacing, 0);
  }
  
  //second section of lines
  stroke(random(colorRange), random(colorRange), random(colorRange));
  for(int i = 0; i < width; i+=spacing){
    line(i, height/2, i, height/4);
  }
  
  //third section of lines
  stroke(random(colorRange), random(colorRange), random(colorRange));
  for(int i = 0; i < width; i+=spacing){
    line(i, height/2, i-spacing, 3*height/4);
  }
  
  //fourth section of lines
  stroke(random(colorRange), random(colorRange), random(colorRange));
  for(int i = 0; i < width; i+=spacing){
    line(0, 3*height/4 + i, width, 3*height/4+i);
  }
  
  //bisector lines
  stroke(0); //changing the bisector lines to black
  strokeWeight(5); //changing the stroke weight for the bisector lines
  line(0, height/4, width, height/4);
  line(0, height/2, width, height/2);
  line(0, 3*height/4, width, 3*height/4);
}
