//This sketch plays music and the background image fades in and out based on the amplitude of the song
//Can pause the song using the spacebar
//can add your own flair to the song by pressing the pads on the screen.
//each press of the pad changes the hue of the background momentarily


//import the processing sound library
import processing.sound.*;

//future storage
PImage img; //stores the image
SoundFile music; //stores the song
Amplitude amp = new Amplitude(this); //stores the songs amp
Amplitude padAmp= new Amplitude(this); //stores one of the pad's music files amp
Pad[] pads = new Pad[4]; //array of pads for us to click on

void setup() {
  size(600, 600); //size of the picture, therefore size of the canvas
  background(0);
  colorMode(HSB, 360, 100, 1); //max limit for brightness is 1 so that amp can correlated to it

  img = loadImage("picture.png"); //loads the picture
  music = new SoundFile(this, "TheProcess.mp3"); //mp3 files dont work, keep getting arrayindexoutofbound & .wav file is too big for github
  music.play(); //defaults the music to start playing

  amp = new Amplitude(this); //something something allows amplitude of a file to be stored 
  amp.input(music); //takes the amplitude of the music 

  //sound files for the pads
  SoundFile[] files = {new SoundFile(this, "kick.wav"), 
    new SoundFile(this, "snare.wav"), 
    new SoundFile(this, "open-hi-hat.wav"), 
    new SoundFile(this, "closed-hi-hat.wav")};

  //populate our pads array
  for (int i = 0; i < pads.length; i++) {
    pads[i] = new Pad(150 + 80*i, 3*height/4 - 25, 50, color(90 * i, 100, 100), files[i]);
    padAmp.input(files[i]);
  }
}

void draw() {
  background(0);
  tint(120, 100, 1.7 * amp.analyze()); //tint of brightness is based on the song's amp
  image(img, 0, 0, width, height);

  for (int i = 0; i < pads.length; i++) {
    //show the pads
    pads[i].show();

    //check for clicks. 
    if (mousePressed &&
      mouseX > pads[i].x &&
      mouseX < pads[i].x + pads[i].side &&
      mouseY > pads[i].y &&
      mouseY < pads[i].y + pads[i].side) {

      pads[i].clicked();
      tint(padAmp.analyze()+300, 100, 1.7 * amp.analyze());
      image(img, 0, 0, width, height);
    }
  }

  //this is repeated to make sure the buttons are always showing cause making it change the hue of the image causes them to flicker
  for (int i = 0; i < pads.length; i++) {
    pads[i].show();
  }
}

void keyPressed() {
  if (key == ' ' && music.isPlaying()) //if the key pressed is the spacebar and the music is playing then its stops the song
    music.stop();
  else if (key == ' ')//if not it plays the song
    music.play();
}
