class Projectile{
  PVector pos, vel;
  float r = 5, s = 1, angle = 0;
  int type;
  boolean isOut;
  color colour = #FFFFFF;
  
  Projectile(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
  }
  
  Projectile(PVector pos, PVector vel, float scale, int type){
    this.pos = pos;
    this.vel = vel;
    this.s = scale;
    this.type = type;
  }
  
  void update(){
    pos.add(vel);  
    if (type == 1){        //if its boss's bomb
      this.angle = atan2(player.pos.y - this.pos.y, player.pos.x- this.pos.x);
      this.vel = PVector.fromAngle(this.angle); 
      this.vel.mult(5); }   
    checkWalls();
    drawBullet();
  }
  
  
  void checkWalls(){      
      if ( this.pos.x<0 || this.pos.x>width || this.pos.y<0 || this.pos.y>height ) {   
        this.isOut = true;
      }
      else    
        this.isOut = false;
     
      
  }
  
  boolean hit(Character otherChar){
    if ( dist(this.pos.x, this.pos.y, otherChar.pos.x, otherChar.pos.y) < otherChar.cWidth + r*2 ){
      return true;
    }
    return false;
  }
  
  
  boolean hitCharacter(Character other){                              //ENCLOSED CIRCLE COLLISION DETECTION
    if (abs(pos.x - other.pos.x) < 2+other.cWidth/2   &&   
        abs(pos.y-10 - other.pos.y) < 2+other.cHeight/2) { 
      return true;
    }    
    return false;
  }
  
  void drawBullet(){
    pushMatrix();    
    translate(pos.x, pos.y-40);
    fill(#FFFFFF);                      //bullet color
    if (type == 1){      fill(#CB0000);}    //bomb color
    strokeWeight(1);
    scale(s);
    ellipse(0,0,5,5);
    popMatrix();
  }
  
}
