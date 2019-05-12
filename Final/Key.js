class Key {
    /*fields & constructors*/
    constructor(x = 0, w = 0, type = false, note = '', pressed = '', midi) {
        this.x = x; //starting position of each key
        this.w = w; //width of each key
        this.type = type; //tells wheter its a black key or a white key
        this.h = height; //height of each key
        this.pressed = pressed; //the keyboard key for each piano key on screen
        this.note = note; //the piano note for the key

        this.midi = midi;
        this.osc = new p5.SinOsc();
        this.envelope = new p5.Envelope();

        this.white = 255;
        this.black = 0;

        this.osc.amp(0);
        this.osc.start();

        // set attackTime, decayTime, sustainRatio, releaseTime
        this.envelope.setADSR(0.001, 0.5, 0.1, 0.5);

        // set attackLevel, releaseLevel
        this.envelope.setRange(1, 0);

        this.time = 0;
        this.fft = new p5.FFT();

        this.visualX = 0;

        if(this.pressed == 'Z'){
            this.c = color(255, 0, 0);
            this.cV2 = color(255, 0, 0, 20);
        }
        if(this.pressed == 'X'){
            this.c = color(255, 150, 0);
            this.cV2 = color(255, 110, 0, 20);
        }
        if(this.pressed == 'C'){
            this.c = color(255, 255, 0);
            this.cV2 = color(255, 255, 0, 20);
        }
        if(this.pressed == 'V'){
            this.c = color(0, 255, 0);
            this.cV2 = color(0, 255, 0, 20);
        }
        if(this.pressed == 'B'){
            this.c = color(0, 0, 255);
            this.cV2 = color(0, 0, 255, 20);
        }
        if(this.pressed == 'N'){
            this.c = color(125, 50, 155);
            this.cV2 = color(125, 50, 155, 20);
        }
        if(this.pressed == 'M'){
            this.c = color(255, 0, 255);
            this.cV2 = color(255, 0, 255, 20);
        }

        if(this.pressed == 'S'){
            this.c = color(255, 150, 150);
            this.cV2 = color(255, 150, 150, 20);
        }
        if(this.pressed == 'D'){
            this.c = color(255, 210, 130);
            this.cV2 = color(255, 210, 130, 20);
        }
        if(this.pressed == 'G'){
            this.c = color(200, 255, 200);
            this.cV2 = color(200, 255, 200, 20);
        }
        if(this.pressed == 'H'){
            this.c = color(175, 200, 255);
            this.cV2 = color(175, 200, 255, 20);
        }
        if(this.pressed == 'J'){
            this.c = color(197, 139, 231);
            this.cV2 = color(197, 139, 231, 20);
        }
    }

    /*methods*/
    show() {
        stroke(0);
        strokeWeight(1);
        if (this.type) {

            fill(this.white); 
            rect(this.x, this.h / 2, this.w, this.h);
            
            fill(0); //change text color to black
            textSize(20); //change text size to 16
            textAlign(CENTER)
            text(this.pressed, this.x + this.w/2, 9*this.h/10);
            fill(this.c);
            stroke(0);
            textSize(14)
            strokeWeight(2);
            text(this.note, this.x + this.w/2, 1.6*this.h/3);
        } else {
            stroke(0);
            strokeWeight(1);
            fill(this.black);
            rect(this.x, this.h / 2, this.w, this.h / 3)

            fill(255); //change text color to black
            textSize(20); //change text size to 16
            textAlign(CENTER)
            text(this.pressed, this.x + this.w/2, 2.3*this.h/3 );
            fill(this.c);
            stroke(0);
            textSize(14)
            strokeWeight(2);
            text(this.note, this.x + this.w/2, 1.6*this.h/3 );
        }
    }

    play() {
        this.osc.freq(midiToFreq(this.midi));
        this.envelope.play(this.osc, 0, 0.1);
    }

    visualize() {
        let waveform = this.fft.waveform(); // analyze the waveform
        beginShape();

        stroke(this.c);
        noFill();
        strokeWeight(5);
        for (let i = 0; i < waveform.length; i++) {
          let vX = map(i, 0, waveform.length, 0, width);
          let vY = map(waveform[i], -1, 1, height/3, height/6);
          vertex(vX, vY);
        }
        endShape();

        beginShape();
        stroke(this.cV2);
        noFill();
        strokeWeight(100);
        for (let i = 0; i < waveform.length; i++) {
          let vX = map(i, 0, waveform.length, 0, width);
          let vY = map(waveform[i], -1, 1, height/3, height/6);
          vertex(vX, vY);
        }
        endShape();
    }

}