/*
  a sketch that draws a forest in the night based on csv data on trees
 */

Table trees; //holds the tree csv file

float treeGirth; //holds the ith tree's girth
float treeHeight; //holds the ith tree;s height
float treeVolume; //holds the ith tree's volume

void setup() {
  colorMode(HSB, 360, 100, 100); 
  size(1280, 720); 
  background(222, 97, 27); //dark blue background

  drawMoon(); //draws a moon that has a 3dish look or whatever

  fill(146, 86, 17);
  noStroke();
  rect(0, 2*height/3, width, height/3); //rectangle for a grass

  trees = loadTable("trees.csv", "header");

  int rowCount = trees.getRowCount();

  for (int i = 0; i < rowCount; i++) {
    TableRow row = trees.getRow(i); 
    treeGirth = row.getFloat("Girth in in");
    treeHeight = row.getFloat("Height in ft");
    treeVolume = row.getFloat("Volume in ft^3");
    drawTree(rowCount, i, treeGirth, treeHeight, treeVolume);
  }

  //drawLeaves();
}

void drawTree (float r, float i, float g, float h, float v) {
  fill(32, 100, 24+(0.1*h)); //the shade of the color is based on the height

  rect(random((width/r)*i, (width/r)*(i+1)), //starts the trunk in a random place based on it's index
    height + random(-50, 50), //starts the trunk at a random y value within 50 pixels from the bottom of the canvas
    g*2, //the width of the rectangle is based on the girth of the ith tree
    -(h*10)); //the height of the ith tree is based on the height from the csv file


  //draws leaves for ith tree
  fill(146, 86, 17, 50);
  for (int j = 0; j <g*10; j++) {
    circle(random((width/r)*i, (width/r)*(i+1)), //bounds the circle to be within the ith tree and the next tree
          random(0, height/3), //bounds the circle to be in the first third 
          h/2); //size of the leaf is based on height
  }
}


//draws a moon in the middle of the canvas 
void drawMoon() {
  fill(0, 0, 100, 5);
  for (int i = 0; i < height/10; i++) {
    circle(width/2, height/2, (height/100) * i);
  }
}
