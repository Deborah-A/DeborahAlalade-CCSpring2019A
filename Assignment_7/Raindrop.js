class Raindrop {

    constructor(position = new Vector2D(random(-200, width), height / 20), velocity = new Vector2D(2, random(3, 5)), size = 2, lifespan = height/2) {
        this.position = position;
        this.velocity = velocity;
        this.size = size;
        this.lifespan = lifespan;
    }

    move() {
        this.position.add(this.velocity);
        this.lifespan -= 2.0;
    }

    show() {
        stroke(3, 74, 255, 100);
        fill(3, 74, 255, 100);
        circle(this.position.x, this.position.y, this.size);
    }

    isDead(){
        if (this.lifespan < 0.0)
            return true;
        else
            return false;
      }
}