class Missle {
float x,y, speed; 
Missle(float x, float y, float speed){
  this.x =x; 
  this.y = y;
  this.speed=speed;
}
void display(){
  fill(255, 255, 0);
  rect(x, y, 10, 10);
   x+=speed+1;
}

}
