var bob;
var xSpacing = 10; //spacing between ellipses for wave
var w; // Width of entire wave
var theta = 0.0; // Start angle at 0
var dx; // Value for incrementing X, a function of period and xSpacing
var yvalues= []; //an array to store y values for the wave

function setup() {
    createCanvas(1280, 720);

    w = width + 150;
    dx = (TWO_PI / 500) * xSpacing;
    //yvalues = new float[w / xSpacing];
}

var xoff = 0; //beggining of xoffset

function draw() {
    bob = 10 * sin(50 * frameCount); //bob increases and decreases everytime frameCount increases
    background(125, 200, 250);
    drawChara(3 * width / 4, 3 * height / 10, .5);
    drawChara(2 * width / 3, height / 4, .6);
    drawBoat();
    calcWave();
    drawWave();

    //saveFrame();
}

//draws the character at a specific size on a specific xCoord & yCoord on the canvas
function drawChara(xCoord, yCoord, s) {
    push();
    translate(xCoord, yCoord + bob);
    scale(s);
    //body
    stroke(0);
    strokeWeight(5);
    line(0, 50, 0, 200);

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
    if (frameCount % 60 < 30)
        line(-75, 50, 75, 150);
    else
        line(-75, 150, 75, 50);

    //legs
    line(0, 200, -75, 300);
    line(0, 200, 75, 300);
    pop();
}

function calcWave() {
    theta += .1;
    var x = theta;
    for (let i = 0; i < w/xSpacing; i++) {
        yvalues[i] = 50 * sin(x); //saves the y value in the array
        x += dx;
    }
}

//draws the wave from calculated y values by making an ellipse at the yCoord for the given xCoord
function drawWave() {
    noStroke();
    fill(0, 100, 150);
    for (let x = 0; x < w/xSpacing; x++) {
        ellipse(x * xSpacing, (height) + yvalues[x], 150, 150);
    }
}

//draws the boat
function drawBoat() {
    //the sail pole
    stroke(0);
    strokeWeight(10);
    line(width / 2, height / 2 + bob, width / 2, -100 + bob);

    //the sail
    noStroke();
    fill(255);
    triangle(width / 2, height / 3 + bob, width / 8, height / 3 + bob, width / 2, -100 + bob);

    //the boat
    fill(150, 75, 25);
    arc(width / 2, (height / 2) + bob, 7 * width / 8, 3 * height / 2, 0, PI);
}