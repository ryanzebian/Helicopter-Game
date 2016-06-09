HelicopterClass Helicopter;
PImage backgroundImage;
float x = 200;
float y = 300;
PFont font;
int OHScale = 80; //obstacle height scale
float gSpeed= 10; //speed of the game
Boolean paused= false;
Boolean shoot= false;; 
Missle test;
Obstacle[] ob = new Obstacle[2];
Obstacle[] topb = new Obstacle[20];
Obstacle[] botb = new Obstacle[20]; 
//Obstacle[] obstacles = new Obstacle[10];


void setup() {
  size(800, 650);
  
  //intializes the helicopter
  Helicopter = new HelicopterClass();
  
  //intialize the obstacles
  obstint(ob); //intializes the obstacle array
  
}

void draw() {
       background(0);
       //top and bottom borders resets
       for(int i=0; i<topb.length; i++)
       {
          if(topb[i].x <= -topb[i].w){
            topb[i].x= width;
            botb[i].x= width;
          }
             // Draw
         topb[i].display();
         botb[i].display();
       }
       
       //same for moving obstacles.. 
       for(int i=0; i<ob.length; i++){
         if(ob[i].x <= -ob[i].w){
           ob[i].x= width + 300;
           ob[i].y= random(OHScale, (height-OHScale)- OHScale );//moves the object
           ob[i].obs = color(0, 100, 0);
           ob[i].shot= false;
         }
         ob[i].display();
       
       }
       // checks if missle is launched
      if(shoot){
      test.display();
   
      for(int i=0; i<ob.length;i++){ //checkis if hit     
      if(test.x+10 >= (ob[i].x - width) && (test.y< (ob[i].y + ob[i].h) ) && test.y > (ob[i].y- ob[i].h) )// add explosion
      {
        ob[i].shot= true;
        ob[i].obs = color(0);
      } 
     }
      
   }
        
       if(mousePressed)  //moving the helicopter
         Helicopter.drawing(true);
        else 
         Helicopter.drawing(false);
         
      collision(); //check for collision 
      
}

  void obstint(Obstacle [] temp)
  {
    
    float heightstep= 0.1;
    float heightdiff= 0;
    OHScale = 80;
    
     //applying the random varialbe (perlin noise to draw the borders)
     heightdiff += heightstep;
     float Oheight = noise(heightdiff) *OHScale;
       //intializes the upper and lower borders of the game
    for(int i=0; i< topb.length; i++) //topobstacle array and bot array has the same length
      {
        topb[i] = new Obstacle( i* 45, 0, 45, Oheight, gSpeed);
        botb[i] = new Obstacle( i*45, height -(OHScale -Oheight), 45, (OHScale -Oheight) + Oheight, gSpeed);
      }
      
      
    //intializes the moving obstacle
    for(int i=0; i< temp.length; i++)
    {
     temp[i] = new Obstacle( (i+1) *600, random(60, (height- 60) - 60), 60, 60, 10);
    }
 
  


}
    
    void keyPressed() {
      
  if(key == 'z'|| key =='Z'){ //shoots the missle 
     shoot= true; 
     test = new Missle(Helicopter.x, Helicopter.y, gSpeed);
  }
  if(key == 'p' || key == 'P') {
    if(paused) {
      loop();
    } 
    else 
    {
      noLoop();
    }
    paused = !paused;
  }
  
 
  }
  //checks for the collision of the three obstacle arrays
  void collision(){ 
    
    for(int i=0; i< topb.length; i++){
    
      if(topb[i].detectH(Helicopter) || botb[i].detectH(Helicopter)){
        println("Game Over");
        noLoop();
        Helicopter.HelicopterImage= loadImage("cHelicopter.png" );
        Helicopter.display(Helicopter.x, Helicopter.y);
        break; 
      }
    }
    for(int i=0; i< ob.length; i++){
      
      if(ob[i].detectH(Helicopter)){
        println( "Game Over");
        noLoop();
        Helicopter.HelicopterImage= loadImage("cHelicopter.png" );
        Helicopter.display(Helicopter.x, Helicopter.y);
        break;
      }
    }
  

  }
  
 


