var rainStrength = 1;
var g = 82;
var currentG;

//variables for grass function
var grassNum = 300; // number of individual grass on the field
var grassX=[]; //an array for the grass x coord
var grassH=[]; // an array for the grass height so it kind of simulates grass growing at diff rates

var cloud;


function setup() {
    createCanvas(900, 900);
    background(153, 255, 255);
    currentG = color(160, 82, 45);

    cloud = new Cloud();

    //fills the array with a random number for the x position of each individual grass out of grassNum
    for (let i = 0; i < grassNum; i++)
        grassX[i]= (random(1, width));

    //fills the array with a random number of heights corresponding to a certain index of an individual grass out of grassNum
    for (let i = 0; i < grassNum; i++)
        grassH[i] = random((9 * height / 10), height);

    
}

function draw() {
    background(153, 255, 255); //blue sky

    //grass
    

    cloud.show(); //displays the cloud
    cloud.run(); 

   for(let i = 0; i <rainStrength; i++)
      cloud.addParticle(); //rain

   //grass
    growGrass(); //changes the color of the grass at a gradual rate and increases the length of the grass
    showGrass(); //displays the grass

}

//changes the color of the grass at a gradual rate and increases the length of the grass
function growGrass() {
    if (frameCount % 30 == 0) //changes color and increases height at a gradual rate
    {
        if(g < 202)
            currentG = color(160, g += 10, 45); // green is increasing by one
        for (let i = grassNum; i >=0; i--){
            if(frameCount < 5000)
                grassH[i] -= 3; // increases height by 0.01 for each individual grass   

        }

    }
}

//shows the grass grown
function showGrass() {
    fill(currentG);
    noStroke();
    rect(0, 9 * height / 10, width, height / 10);

    strokeWeight(1);
    stroke(currentG);
    for (let i = grassNum; i >=0; i--)
        line(grassX[i], 9 * height / 10, grassX[i], grassH[i]);
}

 