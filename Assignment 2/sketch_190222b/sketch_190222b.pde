//Deborah Alalade
//Assignment 2: Solving Sol
//Wall Drawing #295 (1976)
//Six white geometric figures (outlines) superimposed on a black wall

//variables
int numShapes = 6; //number of shapes
int vertexLo = 2; //the lower range of the number of vertices between each shape
int vertexHi = 5; //the upper range of the number of vertices between each shape
int white = 255; //color of stroke

float startX; //starting x coord of shape
float startY; //starting y coord of shape
int numVertices; //a random number of vertices between the start and end point for each shape

void setup(){
  size(720, 720);
  background(0); //background black
  strokeWeight(5); 
  stroke(255); //stroke is white
  noFill(); //shapes are just outlines
  
  //draws a random shape with starting/ending point startX, startY
  for(int i = 0; i < numShapes; i++){
    startX = random(width);
    startY = random(height);
    numVertices = (int)random(vertexLo, vertexHi);
    
    beginShape();
    vertex(startX, startY);
    //randomizes location of a random amount of vertices to make a random shape
    for(int j=0; j < numVertices; j++){
      vertex(random(width), random(height)); 
    }
    vertex(startX, startY); //ends the shape at it's starting location to enclose it
    endShape();
  }
  
}
