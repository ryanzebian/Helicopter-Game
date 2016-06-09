class HelicopterClass
{
  PImage HelicopterImage;
  color c;
  float gravity, y, step, x; //gravity is added to make the game more realistic
    
  HelicopterClass()  {
    HelicopterImage  = loadImage("Helicopter.png");
    c = color(0); 
    y=150;
    step= 2;
    gravity= 0.5;
    x= 80;
  }
  
  void drawing(boolean upward) //whether the helicopter is accelerating upwards or decceleriating downwards.. 
  {
    if(upward){
      step -=gravity;
    }
    else{
      step +=gravity;
    }
   
    // Setting a contstaint to limit the step to jumping.
    
    if(step > 4)
      step = 4;
    if(step < -4) 
      step = -4;
    
    y += step;
    display( x, y);
    
  }
  
  public void display( float x, float y){
    //fill(c);
    image(HelicopterImage, x, y, HelicopterImage.width, HelicopterImage.height);
  }
}
   
