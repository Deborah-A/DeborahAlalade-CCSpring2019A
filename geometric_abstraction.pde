void setup(){
  size(900, 1200); // sets the canvas size to 900 by 1200
  
  background(240, 230, 220); //makes the background off-white
  strokeWeight(0); //removes the stroke
  
  //gray rectangles
  fill(100); // makes the background of the rectangles gray
  rect(135, 200, 630, 60);
  rect(135, 930, 630, 60);
  
  //black rectangles and shapes
  fill(60); //makes the rectangles/shape off-black
  rect(135, 600, 185, 330);
  quad(265, 260, 335, 260, 220, 500, 165, 475);
  
  //outlined black shape
  fill(0, 0, 0, 0); //makes fill transparent
  stroke(60); //makes stroke black
  strokeWeight(5);
  quad(590, 390, 660, 390, 710, 542, 640, 542);
  
  //blue rectangles and shapes
  strokeWeight(0);
  fill(90, 120, 150); //makes the fill blue
  stroke(90, 120, 150); //makes the stroke the same color as fill
  rect(450, 260, 60, 670); //vertical bar
  rect(320, 540, 440, 60); //horizontal bar
  quad(320, 540, 320, 600, 190, 550, 220, 500);
  
  //yellow shape
  fill(240, 210, 100); //makes fill yellow
  stroke(240, 210, 100); //matches stroke to fill
  quad(320, 780, 390, 780, 450, 930, 380, 930);
  
  //green shape
  fill(100, 150, 110); //makes fill green
  stroke(100, 150, 110); //matches stroke to fill
  rect(620, 630, 35, 250);
  rect(655, 710, 105, 35);
  quad(510, 680, 620, 710, 620, 745, 510, 720);
  
  //outlined rectangles
  fill(0, 0, 0, 0); //makes fill transparent
  strokeWeight(5); //increases stroke weight
  stroke(240, 230, 220); //makes stroke background color
  quad(160, 850, 250, 670, 310, 670, 220, 850);
  
  //outlined circles
  ellipseMode(CENTER);
  stroke(200, 100, 100); //makes stroke red
  ellipse(690, 350, 90, 90);
  
  stroke(240, 210, 100); //makes stroke yellow
  ellipse(370, 440, 120, 120);
  
  strokeCap(SQUARE); //changes stroke cap to square
  
  //Q1 red cross
  stroke(200, 100, 100); //makes stroke red
  line(135, 330, 232, 330);
  line(185, 280, 185, 380);
  
  //blue cross
  stroke(90, 120, 150); //makes stroke blue
  line(560, 310, 660, 310);
  line(610, 260, 610, 360);
  
  //Q3 red cross
  stroke(200, 100, 100); //makes stroke red
  line(320, 700, 440, 700);
  line(390, 650, 390, 750);
    
  //yellow line
   stroke(240, 210, 100); //makes stroke yellow
   line(190, 700, 320, 700);
   
   //black cross
   stroke(60);
   line(590, 660, 765, 660);
   line(710, 600, 710, 860);
   
  
}
