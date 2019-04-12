class Cloud {
    constructor() {
        this.drops = [];
        this.origin = new Vector2D(0, 0);
    }

    show() {
        fill(255);
        noStroke();
        ellipse(2 * width / 5, height / 6, 2 * width / 5, height / 4);
        ellipse(0, (height / 150) + (height / 6), width / 2, height / 5);
        ellipse(2 * width / 3, -50 + height / 6, 300, 300);
        ellipse(width, (height / 6), -3 * width / 5, height / 4);
        rect(0, height / 5, width, height / 10);
    }

    run() {
        //loop through the particle system
        push();
        translate(this.origin.x, height / 4);
        for (let i = 0; i < this.drops.length; i++) {
            var p = this.drops[i]; //store the current particle
            p.show(); //show it
            p.move(); //move it

            if (p.isDead()) {
                this.drops.splice(i, 1);
            }
        }
        pop();

    }

    addParticle() {
        this.drops.push(new Raindrop());
    }
}