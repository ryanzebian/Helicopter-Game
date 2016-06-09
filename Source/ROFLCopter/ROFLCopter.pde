/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/49529*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
// Simon. S 2012
// Seb's Game Assignment
// ROFLCopter Ver. 01

// LIBRARIES
import ddf.minim.*;

// CONSTANTS
int MAIN_MENU = 1;
int PLAYING = 2;
int GAME_OVER = 3;

// GLOBALS
int gameState;
int score;
int scoreBest = 0;
int gameSpeed;
int baseMPH = 30;
int blockHeightScale;
boolean muted = false;

PImage ROFLCopter;
PImage ROFLCopter_bg;
PFont font;
Minim minim;
AudioPlayer soundtrack;

Block[] upperBlocks = new Block[17];
Block[] lowerBlocks = new Block[17];
Block[] obstacleBlocks = new Block[2];
Helicopter helicopter;

void setup() {
  
  size(640, 480);
  frameRate(60);
  smooth();
  
  noStroke();
  
  // Initialise player unit image
  ROFLCopter = loadImage("ROFLCopter.gif");
  ROFLCopter_bg = loadImage("ROFLCopter_bg.gif");
  
  // Initialise font
  font = createFont("V5PRC___.TTF", 19);
  //textFont(font);
  
  textAlign(CENTER);
  /*
  // Initialise audio
  minim = new Minim(this);
  soundtrack = minim.loadFile("ROFLCopter.mp3");
  soundtrack.loop();
  soundtrack.setGain(-5);
  */
  // Initialise our game
  gameInit();
      
}

void draw() {
    
  switch(gameState) {
    
     // We test PLAYING first, for efficiency,
     // as it will test true 99% of the time.

     // PLAYING
     case 2:
       //background(0);
       image(ROFLCopter_bg, 0, 0);
       
       // Render upper and lower blocks
       for(int i = 0; i < upperBlocks.length; i++) {
         
         // If an upper block is 100% off the screen, move it and the lower block to the end of the line
         if(upperBlocks[i]._x <= -upperBlocks[i]._w) {
           upperBlocks[i]._x = width;
           lowerBlocks[i]._x = width;
         }
         
         // Draw upper and lower block objects to the screen and update their position
         upperBlocks[i].render();
         lowerBlocks[i].render();
         
       }
       
       // Render obstacle blocks
       for(int i = 0; i < obstacleBlocks.length; i++) {
         
         // Move obstacle back to the beginning if it's off the screen
         if(obstacleBlocks[i]._x <= -obstacleBlocks[i]._w) {
           obstacleBlocks[i]._x = width + 340;
           obstacleBlocks[i]._y = random(blockHeightScale, (height - blockHeightScale) - blockHeightScale);
         }
         
         // Draw
         obstacleBlocks[i].render();
         
       }
       
       // Render our helicopter and tell it whether to rise or fall
       if(mousePressed) {
         helicopter.render(true);
       } else {
         helicopter.render(false);
       }
       
       // Check for collisions against upper and lower Block Objects
       for(int i = 0; i < upperBlocks.length; i++) {
         
           if(lowerBlocks[i].checkCollision(80, helicopter._y, 40, 40) || 
            upperBlocks[i].checkCollision(80, helicopter._y, 40, 40)) {
              
           gameState = GAME_OVER;
           
           // Break out of the loop, because we do not need to check any following collisions
           break;
           
         }
         
       }
       
       // Check for collisions against obstacle blocks
       for(int i = 0; i < obstacleBlocks.length; i++) {
         
         if(obstacleBlocks[i].checkCollision(80, helicopter._y, 40, 40)) {
              
           gameState = GAME_OVER;
           
           // Break out of the loop, because we do not need to check any following collisions
           break;
           
         }
         
       }
       
       // Increment score and handle best score
       score++;
       scoreBest = score > scoreBest ? score : scoreBest;
       
       textAlign(LEFT);
       fill(255);
       
       // Display score
       textFont(font);
       text("SCORE: " + score, 20, (height - 19) - 1);
       
       // Display best score
       textAlign(RIGHT);
       text("MPH: " + baseMPH * gameSpeed, width - 20, (height - 19) - 1);
       
       // Every set amount of score, ramp up the speed - good luck!
       if(score % 500 == 0 && gameSpeed != 10) {
         
         // Factors of 40: 1, 2, 4, 5, 8, 10, ...
         switch (gameSpeed) {
           case 1:
             gameSpeed = 2;
             break;
           case 2:
             gameSpeed = 4;
             break;
           case 4:
             gameSpeed = 5;
             break;
           case 5:
             gameSpeed = 8;
             break;
           case 8:
             gameSpeed = 10;
             break;
        }
         
         for(int i = 0; i < upperBlocks.length; i++) {
           upperBlocks[i]._xVel = -gameSpeed;
           lowerBlocks[i]._xVel = -gameSpeed;
         }
         
         for(int i = 0; i < obstacleBlocks.length; i++) {
           obstacleBlocks[i]._xVel = -gameSpeed;
         }
       
       }
       
       break;
      
      // GAME_OVER, dude
      case 3:
        image(ROFLCopter_bg, 0, 0);
        
        textAlign(CENTER);
        fill(255);
        
        textFont(font, 57);
        text("GAME OVER", width / 2, height / 2);
        
        textFont(font);
        text("YOU SCORED " + score + "!", width / 2, (height / 2) + 57);

        break;
      
      // MAIN_MENU
      case 1:
        image(ROFLCopter_bg, 0, 0);
        
        textAlign(CENTER);
        fill(255);
        
        textFont(font, 57);
        text("ROFLCopter", width / 2, height / 2);
        
        textFont(font);
        text("CLICK TO BEGIN", width / 2, (height / 2) + 57);
        
        // Display best score
        textAlign(LEFT);
        fill(255);
        text("BEST SCORE: " + scoreBest, 20, (height - 19) - 1);
        
        // Display mute toggle instruction
        textAlign(RIGHT);
        text("\"M\" TO MUTE", width - 20, (height - 19) - 1);
        
        break;
        
      default:

        println("Error! The game has not been initialised.");
        noLoop();
      
        // No break, because we stopped draw()'ing, above.
  }
  
}

void gameInit() {
  
  // A global function that initialises
  // game defaults and allows us to
  // reinitialise after a game over.
  
  // Set defaults
  gameState = MAIN_MENU;
  score = 0;
  gameSpeed = 1;
  
  // Reset world
  float blockHeightOffset = 0;
  float blockHeightIncrement = 0.1;
  blockHeightScale = 80;
  
  for(int i = 0; i < upperBlocks.length; i++) {
    
    // Here, we generate a Perlin noise value and
    // use it to assign the height of each object.
    
    blockHeightOffset += blockHeightIncrement;
    float blockHeight = noise(blockHeightOffset) * blockHeightScale;

    upperBlocks[i] = new Block(i * 40, 0, 40, blockHeight, color(0, 200, 0), -gameSpeed);
    lowerBlocks[i] = new Block(i * 40, height - (blockHeightScale - blockHeight), 40, (blockHeightScale - blockHeight) + blockHeight, color(0, 200, 0), -gameSpeed);
    
  }
  
  // Reset obstacles
  for(int i = 0; i < obstacleBlocks.length; i++) {
    obstacleBlocks[i] = new Block((i + 1) * 500, random(blockHeightScale, (height - blockHeightScale) - blockHeightScale), blockHeightScale, blockHeightScale, color(0, 200, 0), -gameSpeed);
  }
  
  // Reset helicopter
  helicopter = new Helicopter(height / 2);
  
}

void mousePressed() {
  
  // This function handles all mouse clicks that don't
  // require polling to detect whether they've been held.
  
  // At main menu, send player to game upon click
  if(gameState == MAIN_MENU) {
    gameState = PLAYING;
    
  // At game over, send player to main menu upon click
  } else if (gameState == GAME_OVER) {
    gameInit();
  }
  
}

void keyPressed() {
  
  if(key == 'm' || key == 'M') {
    if(muted) {
      soundtrack.unmute();
    } else {
      soundtrack.mute();
    }
    muted = !muted;
  }
  
}
