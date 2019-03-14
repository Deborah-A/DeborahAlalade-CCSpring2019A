class Cloud 
{
  /* fields */
  ArrayList<RainDrop> drops = new ArrayList<RainDrop>(); //the particles of this system
  Vector2D origin = new Vector2D(0, 0); //the position that all the particles come from
  public int splashDist = 5;
  /* constructors */
  //default constructor
  public Cloud(){
  }
  
  //constructor that positions the particle system based on a vector argument
  public Cloud(Vector2D o){
    origin.x = o.x;
    origin.y = o.y;
  }
  
  /* methods */
  //method for the cloud to show itself
  void show()
  {
    fill(255);
    noStroke();
    ellipse(width/4, height/4, 200, 200);
    ellipse(0, 50+height/4, 300, 100);
    ellipse(2*width/3, -50+height/4, 300, 300);
    ellipse(width, 25+height/4, 150, 150);
    rect(0, height/4, width, 100);
  }
  
  public void run()
  {
    //loop through the particle system
    pushMatrix();
    translate(origin.x , height/4);
    for(int i = 0; i < drops.size(); i++)
    {
      RainDrop p = drops.get(i); //store the current particle
      p.show(); //show it
      p.move(); //move it
        
      if(p.isDead())
      {
        drops.remove(i);
        
      }
    }
    popMatrix();

  }
  
  public void addParticle(){
    drops.add(new RainDrop());
  }
  
  //overload the addParticle method to add a parta position x,y relative to the origin of the system
  public void addParticle(Vector2D location){
    drops.add(new RainDrop(location)); //add the particle to the location relative to the origin
  }
}
