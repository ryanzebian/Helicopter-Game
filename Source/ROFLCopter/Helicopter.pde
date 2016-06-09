// Helicopter is our
// player unit Class.

class Helicopter {
  
  float _y;
  float _yVel; // Y Velocity (Y Speed)
  float _gravity;
  
  Helicopter(float y) {
    
    _y = y;
    _yVel = 3;
    _gravity = 0.3;
    
  }
  
  void render(boolean rise) {
    
    // To make our helicopter rise
    // we subtract gravity, and to
    // make it fall, we add gravity.
    
    if(rise) {
      _yVel -= _gravity;
    } else {
      _yVel += _gravity;
    }
    
    // Constrain the velocity of our helicopter
    // so that it doesn't get out of control.
    
    if(_yVel > 5) _yVel = 5;
    if(_yVel < -5) _yVel = -5;
    
    _y += _yVel;
    
    image(ROFLCopter, 80, _y);
    
  }
  
}
