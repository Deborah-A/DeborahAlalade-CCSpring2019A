/*Deborah Alalade SP19
  a Processing sketch that showcases object motion within 
  the bounds of the canvas and somehow incorporates user input.
  
  user can make a square based snake shake violently by 
  pressing the UP key and less by pressing the DOWN key
*/

//global vars
float n = 20; //number of rectangles
float rectWidth; //width of rect
float j = 0; //jitter of rects

void setup(){
  size(1280, 720);
  background(100);
  fill(255);
  noStroke();
}

void draw(){
  //background(100); //refresh BG
  
  rectWidth = width/n; //sets the rectangle width
  
  //draws rectangles and makes them jitter a random degree based on user input
  for(float i = 0; i<width; i +=rectWidth){ 
     fill(71+random(20), 171+random(20), 108+random(20));
     rect(i, 360 - (rectWidth/2) + random(-j,j), rectWidth, rectWidth);
  }
}

//if user presses down j (jitter) decreases and if user presses up jitter increases
void keyPressed(){  
  if(keyCode == DOWN && j >1){
    j--;
  }else if(keyCode == UP && j<50){
    j++;
  }
}
