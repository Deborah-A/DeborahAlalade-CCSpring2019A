/*  CC Final
    Author:Deborah Alalade
    This sketch is a 12-key piano using oscillators and visually shows the waves on screen. 
    The user can also record their song, auto-play a song, and change the sine wave of the oscllator
*/



/*variables for the piano*/
var whiteMIDI = [60, 62, 64, 65, 67, 69, 71]; // The midi notes of the white keys on a 12-key piano
var whitePressed = ['Z', 'X', 'C', 'V', 'B', 'N', 'M']; //the keyboard keys to press so you can play the note that correspond to the midi notes above
var whiteNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B']; //the piano notes that correspond to the keyboard keys and midi notes above
var blackMIDI = [61, 63, 66, 68, 70]; // The midi notes of the black keys on a 12-key piano
var blackPressed = ['S', 'D', 'G', 'H', 'J']; //the keyboard keys to press so you can play the note that correspond to the midi notes above
var blackNotes = ['C#', 'D#', 'F#', 'G#', 'A#']; //the piano notes that correspond to the keyboard keys and midi notes above
var whiteKeys; //variable to hold the whiteKey objects that can play and visualize a MIDI note for the white keys of the piano
var blackKeys; //variable to hold the blackKey objects that can play and visualize a MIDI note for the black keys of the piano

/*variables for changing oscillator*/
var waveTitle; //title to explain the buttons
var warning; //warning for sqr and saw waves cause they are painful, especially with headphones
var sineButton; //button to change the oscillator wave to a sine wave
var triButton; //button to change the oscillator wave to a triangle wave
var sqrButton; //button to change the oscillator wave to a square wave
var sawButton; //button to change the oscillator wave to a saw wave 

/*variables for autoplay*/
var autoButton; //button for auto play
var index = 0; //variable to change note
var song = [ //the song(a list of notes) for auto play (a slightly messed up Ode to Joy)
    {note: 2, display: "E"},
    {note: 2, display: "E" },
    {note: 3, display: "F" },
    {note: 4, display: "G" },
    {note: 4, display: "G" },
    {note: 3, display: "F" },
    {note: 2, display: "E" },
    {note: 1, display: "D" },
    {note: 0, display: "C" },
    {note: 0, display: "C" },
    {note: 1, display: "D" },
    {note: 2, display: "E" },
    {note: 2, display: "E" },
        {note: 1, display: "D" },
        {note: 1, display: "D" },

    {note: 2, display: "E"},
    {note: 2, display: "E" },
    {note: 3, display: "F" },
    {note: 4, display: "G" },
    {note: 4, display: "G" },
    {note: 3, display: "F" },
    {note: 2, display: "E" },
    {note: 1, display: "D" },
    {note: 0, display: "C" },
    {note: 0, display: "C" },
    {note: 1, display: "D" },
    {note: 2, display: "E" },
    {note: 1, display: "D" },
        {note: 0, display: "C" },
        {note: 0, display: "C" },
];
var autoplay = false; //boolean to check if user pressed autoplay

/*varaibles for recording*/
var recording = false; //checks if the user is already recording
var recorder; //sets up recording
var soundFile; //where the recording will save to

function setup() {
    createCanvas(windowWidth * .99, windowHeight * .99); //create canvas (99% so that there's no scrolling)

    //makes it an empty array so I can push key objects into it
    whiteKeys = []; 
    blackKeys = []; 

    keyboard(); //draws the keyboard and creates the key objects
    recorder = new p5.SoundRecorder();
    recorder.setInput(); //defaults to the sketch's sound output
    soundFile = new p5.SoundFile();

    fill(255);
    waveTitle = createElement('h3', 'Change the Oscillator\'s wave');
    waveTitle.position(width*0.01, height*0.01);
    waveTitle.style('color', '#ffffff')

    warning = createElement('h6', 'Warning: Square and Sawtooth waves are painful. Please don\'t use headphone\'s while using these settings!');
    warning.attribute('align', 'bottom')
    warning.position(width*0.2 , 0.01*height);
    warning.style('color', '#ffffff');

    sineButton = createButton("Sine Wave");
    sineButton.position(width*.01, height*0.06);
    sineButton.mousePressed(changeSine);

    triButton = createButton("Triangle Wave");
    triButton.position(sineButton.width + width*.01, height*0.06);
    triButton.mousePressed(changeTri);

    sqrButton = createButton("Square Wave");
    sqrButton.position(sineButton.width + width*.01 + triButton.width, height*0.06);
    sqrButton.mousePressed(changeSqr);

    sawButton = createButton("Sawtooth Wave");
    sawButton.position(sineButton.width + width*.01 + triButton.width + sqrButton.width, height*0.06);
    sawButton.mousePressed(changeSaw);

    autoButton = createButton("Auto Play Ode to Joy");
    autoButton.position(width - autoButton.width, height*0.02);
    autoButton.mousePressed(autoPlay);

    recordButton = createButton("Record");
    recordButton.position(width  - autoButton.width, height*0.04);
    recordButton.mousePressed(record);
}

function draw() {
    background(25);

    //draw seperation bar for the piano and the visualization
    fill(101, 67, 33);
    noStroke();
    rect(0, height / 2, width, -25)

    showKeys(); //updates the key colors

    run(); //plays and changes the color when ever a key is pressed

    if(autoplay){ //if autoplay is true, which is when the autoplay button is pressed, it will play the song
        autoPlay();
    }
}

function autoPlay(){
    autoplay = true;
    if (autoPlay && frameCount % 25 ==0){ //goes to the next note every 25 frames
        whiteKeys[song[index].note].play();
        whiteKeys[song[index].note].white = 155;
        whiteKeys[song[index].note].visualize();
        // Move to the next note
        index ++;
    } else if (index >= song.length) {
        autoplay = false;
        index = 0;
    }
}

function record(){
    
    if(!recording){
        recorder.record(soundFile);
        recordButton.html( "Recording... Stop?");
        recordButton.style('background-color', color(255,0, 0));
        recording = true;
    } else{
        recorder.stop();
        save(soundFile, 'myRecording.wav');
        recordButton.html("Record");
        recordButton.style('background-color', color(255));
        recording = false;
    }
    
    

}

//plays the play and visualize function of each key if the corresponding keyboard is pressed, also changes the piano key's color if pressed
function run() {
    //highlights keys if pressed 90% of the time
    if (keyIsDown(90)) { //z
        whiteKeys[0].white = whiteKeys[0].c;
        whiteKeys[0].play();
        whiteKeys[0].visualize();
    } else {
        whiteKeys[0].white = 255;
    }

    if (keyIsDown(88)) { //x
        whiteKeys[1].white = whiteKeys[1].c;
        whiteKeys[1].play();
        whiteKeys[1].visualize();

    } else {
        whiteKeys[1].white = 255;
    }

    if (keyIsDown(67)) { //c
        whiteKeys[2].white = whiteKeys[2].c;
        whiteKeys[2].play();
        whiteKeys[2].visualize();

    } else {
        whiteKeys[2].white = 255;
    }

    if (keyIsDown(86)) { //v
        whiteKeys[3].white = whiteKeys[3].c;
        whiteKeys[3].play();
        whiteKeys[3].visualize();

    } else {
        whiteKeys[3].white = 255;
    }

    if (keyIsDown(66)) { //b
        whiteKeys[4].white = whiteKeys[4].c;
        whiteKeys[4].play();
        whiteKeys[4].visualize();

    } else {
        whiteKeys[4].white = 255;
    }

    if (keyIsDown(78)) { //n
        whiteKeys[5].white = whiteKeys[5].c;
        whiteKeys[5].play();
        whiteKeys[5].visualize();

    } else {
        whiteKeys[5].white = 255;
    }

    if (keyIsDown(77)) { //m
        whiteKeys[6].white = whiteKeys[6].c;
        whiteKeys[6].play();
        whiteKeys[6].visualize();

    } else {
        whiteKeys[6].white = 255;
    }

    if (keyIsDown(83)) { //s
        blackKeys[0].black = blackKeys[0].c;

        blackKeys[0].play();
        blackKeys[0].visualize();

    } else {
        blackKeys[0].black = 0;
    }

    if (keyIsDown(68)) { //d
        blackKeys[1].black = blackKeys[1].c;
        blackKeys[1].play();
        blackKeys[1].visualize();

    } else {
        blackKeys[1].black = 0;
    }

    if (keyIsDown(71)) { //g
        blackKeys[2].black = blackKeys[2].c;
        blackKeys[2].play();
        blackKeys[2].visualize();

    } else {
        blackKeys[2].black = 0;
    }

    if (keyIsDown(72)) { //h
        blackKeys[3].black = blackKeys[3].c;
        blackKeys[3].play();
        blackKeys[3].visualize();

    } else {
        blackKeys[3].black = 0;
    }

    if (keyIsDown(74)) { //j
        blackKeys[4].black = blackKeys[4].c;
        blackKeys[4].play();
        blackKeys[4].visualize();

    } else {
        blackKeys[4].black = 0;
    }
}

//shows the key for each loop, which allows for it to update colors if any key is pressed
function showKeys() {
    for (let i = 0; i < whiteKeys.length; i++) {
        whiteKeys[i].show();
        for (let j = 0; j < blackKeys.length; j++) {
            blackKeys[j].show();
        }
    }
}

//draws a 12-key keyboard and creates the key objects for each key
function keyboard() {
    
    let w = width / whiteMIDI.length; // The width for white keys
    for (let i = 0; i < whiteMIDI.length; i++) {
        let x = (i * w); //starts the rectangle at this x value
        whiteKeys.push(new Key(x, w, true, whiteNotes[i], whitePressed[i], whiteMIDI[i])); //build the key object
        for (let j = 0; j < blackMIDI.length; j++) {
            if (blackMIDI[j] < whiteMIDI[i] && blackMIDI[j] > whiteMIDI[i - 1]) {
                blackKeys.push(new Key((x - (w / 4)), (w / 2), false, blackNotes[j], blackPressed[j], blackMIDI[j])); //build the black key object w/ half the w of a white key
            }
        }
    }
}

function changeSine(){
    for (let i = 0; i < whiteKeys.length; i++) {
        whiteKeys[i].osc.setType('sine');
    }
    for (let j = 0; j < blackKeys.length; j++) {
        blackKeys[j].osc.setType('sine');
    }
}

function changeTri(){
    for (let i = 0; i < whiteKeys.length; i++) {
        whiteKeys[i].osc.setType('triangle');
    }
    for (let j = 0; j < blackKeys.length; j++) {
        blackKeys[j].osc.setType('triangle');
    }
}

function changeSqr(){
    for (let i = 0; i < whiteKeys.length; i++) {
        whiteKeys[i].osc.setType('square');
    }
    for (let j = 0; j < blackKeys.length; j++) {
        blackKeys[j].osc.setType('square');
    }
}

function changeSaw(){
    for (let i = 0; i < whiteKeys.length; i++) {
        whiteKeys[i].osc.setType('sawtooth');
    }
    for (let j = 0; j < blackKeys.length; j++) {
        blackKeys[j].osc.setType('sawtooth');
    }
}