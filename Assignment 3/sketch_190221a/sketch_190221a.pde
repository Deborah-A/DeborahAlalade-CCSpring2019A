//Deborah Alalade SP19
//bouncing shapes sketch with varying shapes, sizes, and colors

//define the number of balls in the sketch
int n = 5;

//define contain arrays for positions and speeds
float[] posX = new float[n];
float[] posY = new float[n];
float[] speedX = new float[n];
float[] speedY = new float[n];
float[] r = new float[n];


void setup(){
  size(1280, 720);
  
  //populate the arrays
  for(int i = 0; i < n; i++){
    //give ith shape a random position on the canvas
    posX[i]= random(100, width -100);
    posY[i]= random(100, height -100);
    
    //give ball ith a random speed
    speedX[i]= random(-8, 8);
    speedY[i]= random(-8, 8);
    
    //give ball ith a random radius
    r[i] = random(50,200);
  }

}

void draw(){
 for(int i = 0; i <n; i++){
   //draw ellipses and rects
   ellipse(posX[i],posY[i],r[i], r[i]); 
   rect(posX[i],posY[i],r[i], r[i]); 
   
   //check boundary collisions and reverses the shapes movement path
   if(posX[i] >width || posX[i] <0)
     speedX[i] *=-1;
   if(posY[i] > height || posY[i] <0)
     speedY[i] *= -1;
     
   //moves shapes  
   posX[i] += speedX[i];
   posY[i] += speedY[i];
 }
 
 //changes the color about every 3 seconds
 if(frameCount % 180 == 0){
     fill(random(255), random(255), random(255));
  }

  //saveFrame();
}
