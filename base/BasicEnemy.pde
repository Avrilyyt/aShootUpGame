class BasicEnemy extends Character{
  
  int state = 0, deadTimer = 60;
  float rotate = 0, scale = 1, type = 0,eAngle;
  color colour = #FFFFFF; int alph = 255;
  boolean trackPlayer = false; //whether its gonna bounce off or not
  
  BasicEnemy(PVector pos, PVector vel, float h){
    super(pos, vel, h);       //basic enemy has 3 health   
    super.cWidth = 60;
    super.cHeight = 60;
  }
  
  void update(){
    checkState();
    moveCharacter();
    drawCharacter();
    checkHitPlayer();
    checkWalls(2);
  }
  
  void checkState(){    
    rotate += 0.04*this.health;
    alph = (int)(50+50*this.health);
    if (trackPlayer && this.scale == 1 ){  
      eAngle = atan2(player.pos.y - this.pos.y, player.pos.x- this.pos.x);
      this.vel = PVector.fromAngle(eAngle); 
      this.vel.mult(3);
    }
    if ( this.health == 0 ){ 
      this.vel.y = -0.5;
      if ( deadTimer > 0 ){       
        deadTimer --;               //tick
      }
      if ( deadTimer == 0 ){
        enemies.remove(this);        
      }
    }
  }
  
  boolean getHit(Projectile bullet){
    return pos.dist(bullet.pos) < this.cWidth/2;
  }
  
  void checkHitPlayer(){            //check if enemy hit player. if hit, player lose hp
    if ( this.health > 0 && hitCharacter(player) ){
      trackPlayer = false;
      player.hitProtect();
      resolveCollision();
      
    if ( gameState == 3)        enemies.remove(this);
    }  
  }  
  
  void resolveCollision(){      
      float angle = atan2(this.pos.y - player.pos.y, this.pos.x - player.pos.x);         //find the angle they hit and bounce off each other. 
      float avgSpeed = (this.vel.mag() + player.vel.mag())/2;                      //calculate the average speed                                                                         
      this.vel.set( avgSpeed * cos(angle),  avgSpeed * sin(angle));                //bounce off in opposite directions 
      player.vel.set(avgSpeed * cos(angle - PI), avgSpeed * sin(angle - PI));
  }
  
  void drawCharacter(){
        pushMatrix();
        translate(this.pos.x, this.pos.y);
        scale(scale);        
        stroke(colour, alph);
        strokeWeight(2);
        noFill();  
        triangle(-15,-3, -5,-3, -10,3);    //eyes
        triangle(15,-3, 5,-3, 10,3);
        line(-8,12,8,12);                  //mouth
        triangle(-7,12, -3,12, -5,15);
        triangle(7,12, 3,12, 5,15);
        line(-15,-13,-5,-9);               //eyebrows
        line(15,-13,5,-9);                                      
          pushMatrix();                      //outline
          rotate(rotate);
          beginShape();
          vertex(15,-25);
          vertex(25,-15);
          vertex(25, 15);
          vertex(15, 25);
          vertex(-15,25);
          vertex(-25, 15);
          vertex(-25, -15);
          vertex(-15, -25);
          vertex(15, -25);
          endShape();
          popMatrix(); 
        
        for (int i=0; i<this.health; i++){
          pushMatrix();  
          fill(#CB0000);
          if (type == 0)  rect( 5-cWidth/2+i*cWidth/3, -40, 15,5);
          if (type == 1){  
            scale(0.5);
            rect( 5-cWidth/2+i*cWidth/5, -80, 15,5);}
          popMatrix(); 
        }
        
        popMatrix();        
  }
  
}
