/* Author: Deborah Alalade
  Description: A sketch that grows and revives a field based on if the user hold down the spacebar
  */
  
//variables for cloud particle system
Cloud cloud = new Cloud();
int rainStrength = 5;
int g = 82;
color currentG = color(160, 82, 45); // default color of the grass; brown since it's dead

//variables for grass function
int grassNum = 200; // number of individual grass on the field
int  grassPos[]= new int[grassNum]; //an array for the grass x coord
int grassH[] = new int[grassNum]; // an array for the grass height so it kind of simulates grass growing at diff rates

  
void setup()
{
  size(500, 500);
  background(153, 255, 255);
  
  //fills the array with a random number for the x position of each individual grass out of grassNum
  for(int i = 0; i <grassNum; i++)
    grassPos[i]= (int)random(width);
  
  //fills the array with a random number of heights corresponding to a certain index of an individual grass out of grassNum
  for(int i = 0; i <grassNum; i++)
    grassH[i]= (int)random(6*height/7, 10 + 6*height/7);
   
}
  
void draw()
{
  background(153, 255, 255); //blue sky
 
  //grass
  fill(currentG); noStroke();
  rect(0, 6*height/7, width, 10+height/7);
  
  cloud.show(); //displays the cloud
  cloud.run(); 

  if(keyPressed && key == ' ')
  {
    for(int i = 0; i <rainStrength; i++)
      cloud.addParticle(); //rain

    growGrass(); //changes the color of the grass at a gradual rate and increases the length of the grass
  }
  
  showGrass(); //displays the grass
  //saveFrame();
}



//changes the color of the grass at a gradual rate and increases the length of the grass
void growGrass()
{
    if(frameCount %30 == 0) //changes color and increases height at a gradual rate
    {
      currentG = color(160, g+=2, 45); // green is increasing by one
      for(int i = 0; i <grassNum; i++)
        grassH[i]-= 0.01; // increases height by 0.01 for each individual grass
    }
}

//shows the grass grown
void showGrass()
{
  strokeWeight(1);
  stroke(currentG);  
  for(int i = 0; i <grassNum; i++)
    line(grassPos[i], 6*height/7, grassPos[i], grassH[i]);
}
