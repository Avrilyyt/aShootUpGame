class Character{

  PVector pos, vel;
  float health, cWidth, cHeight;
  
  float damp = 1;
  float radius = 30;  //for collision detection

  Character(PVector pos, PVector vel, float h){
    this.pos = pos;
    this.vel = vel;
    health = h;
  }
  
  void update(){
    moveCharacter();
    checkWalls(1);
  }
  
  
  void moveCharacter(){
   pos.add(vel);
   vel.mult(damp);    //to stop character from moving away after collission
  }
  
  
  void accelerate(PVector forceDirection){
    vel.add(forceDirection);
  }
  
  
  void drawCharacter(){    //"dummy" drawCharacter method
    ellipse(0,0,50,50);
  }
                       
  boolean hitCharacter(Character otherChar){                                //BOUNDING BOX COLLISION DETECTION
    if ( abs(this.pos.x-otherChar.pos.x) < cWidth/2+otherChar.cWidth/2 &&
          abs(this.pos.y-otherChar.pos.y) < cHeight/2+otherChar.cHeight/2){
      return true;
    }    
    return false;
  } 
  
  
  
  void decreaseHealth(int damage) {
    health -= damage;
  }
  
  void addHealth(int damage) {
    health += damage;
  }
  
  
  void checkWalls(int resolution){
    switch(resolution){
    case 1:    
        //resolution 1: resppear on opposite side [PLAYER]  
        if ( pos.x<-cWidth/2 )        pos.x = width+cWidth/2;     //when character hit the left side          
        if ( pos.x>width+cWidth/2 )   pos.x = -cWidth/2;          //when character hit the right side        
        if ( pos.y<-cHeight/2 )        pos.y = height+cHeight/2;   //when character hit the top        
        if ( pos.y>height+cHeight/2)  pos.y = -cHeight/2;         //when character hit the bottom          
        break;
    case 2:    
        //resolution 2: bounce back from wall    [ENEMY]  
        if( pos.x<cWidth/2 || pos.x>width-cWidth/2)      vel.x *= -1;
        if( pos.y<-500 || pos.y>height+100)     enemies.remove(this);
        break;
    }
  }
  
  
}
