class Obstacle
{
  float X, Y = 0; //sets tree position
  float Speed = 0; //sets tree horizontal speed
  PImage obstacleImage = loadImage("Obstacle.gif");
  
  Obstacle (float tempX, float tempY, float tempSpeed)
  {
    X = tempX; //sets starting position and horizontal speed
    Y = tempY;
    Speed = tempSpeed;
  }
  
  void drawObstacle()
  {
    image(obstacleImage, X, Y);
  }
  
  void moveObstacle()
  {
    X += Speed; //tree moves horizontally at horizontal speed
    if(X < 150) //once fully off left edge, reset off right edge
   {
      X = width + random(0,1500); //at random distance from right edge
    }
  }
  
  //void detectObstacleCollision() //if plane hits tree, it's a crash
  //{
    //if ((X + 150 >= heloX) && (X - 200 <= heloX) && (treeY+150>=heloY) && (treeY-65<=heloY))
    //{
     // crash();
    //}
  //}
}


