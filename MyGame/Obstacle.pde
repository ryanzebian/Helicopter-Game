class Obstacle
{
  float x, y, w, h; //sets tree position
  float velocity = 0; //sets tree horizontal speed
  color obs;
  boolean shot= false; //obstacle can be shot by missle.. 
  Obstacle (float x, float y, float w, float h, float velocity)
  {
    //initializes the variables
    this.w=w;
    this.h=h;
    this.x= x; //sets starting position and horizontal speed
    this.y= y;
    this.velocity= velocity;
    obs= color(0,100,0);
  }
  void display() //both moves and draw the obstacle
  {
    moveObstacle();
    drawObstacle();
  }
  
  void drawObstacle()
  {
    
    fill(obs);
    rect(x, y, w, h);
  }
  
  void moveObstacle()
  {
    x -= velocity; //tree moves horizontally at horizontal speed
 
  }
 
  

 boolean detectH(HelicopterClass heli){ //checks if the helicopter collides with the helicopter
   if(!shot){
 return (x< heli.x + heli.HelicopterImage.width) && (x +w) > heli.x && (y < (heli.y + heli.HelicopterImage.height) && (y + h) > heli.y) ;
   }
   return false;
 
 }
}


