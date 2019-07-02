class Player extends Character{
  
  ArrayList<Projectile> bullets = new ArrayList<Projectile>();
  boolean up, down, left, right;
  boolean isMoving, isShooting;
  int gunColor = 90;
  float speedBoost = 1.5,hitTimer = 0;
  
  Player(PVector pos, PVector vel, float h){
    super(pos, vel, h);
    super.damp = 0.7;
    super.cWidth = 80;
    super.cHeight = 105;
  }
  
  
  void update(){
    moveCharacter();
    drawCharacter();
    checkWalls(1);
    checkProjectile();        //check if Player's bullet hit an enemy                   
    if ( player.health <= 0)    gameState = -1;
    if ( gameState != 0 && hitTimer>0)      
        hitTimer --;
  }
  
  void fire(){
    Projectile bullet = new Projectile( pos.copy(), new PVector(0,-10));
    bullets.add(bullet);
  }
  
  
  void checkProjectile(){     //check if Player's bullet hit an enemy    
    for (int i=0; i<bullets.size(); i++){
       Projectile currBullet = bullets.get(i);
       currBullet.update();
       
       for (int n=0; n<enemies.size(); n++) {
          Character currEnemey = enemies.get(n);
          
          if ( currBullet.hit(currEnemey) && currEnemey.health>0 ){    
            currEnemey.decreaseHealth(1);
            bullets.remove(currBullet);
            score.adjustScore(+0.5);        //two hit = 1 point
          }
       }
    }
  }
  
  void hitProtect(){    //1 second protac if player get hit by enemy
    if (hitTimer == 0){
    decreaseHealth(1);    hitTimer = 90;
    }
  }
  
  
  void moveCharacter(){
    if (up){      accelerate(new PVector(0,-1*speedBoost));  isMoving = true;}
    if (left){    accelerate(new PVector(-1*speedBoost,0));    isMoving = true;}
    if (down){    accelerate(new PVector(0,1*speedBoost));     isMoving = true;}
    if (right){   accelerate(new PVector(1*speedBoost,0));     isMoving = true;}
    if (!up && !down && !left && !right)          isMoving = false;
    pos.add(vel);    
    vel.mult(damp);    
  }
      
    
  void checkKeyPressed() {
      if (keyCode == UP || key == 'w' || key == 'W' )    up = true;
      if (keyCode == LEFT || key == 'a' || key == 'A' )  left = true;
      if (keyCode == DOWN || key == 's' || key == 'S' )  down = true;
      if (keyCode == RIGHT || key == 'd' || key == 'D' ) right = true;
      if (key == ' '){                                   fire();    isShooting = true;}
  }


  void checkKeyReleased(){
    if (keyCode == UP || key == 'w' || key == 'W' )      up = false;
    if (keyCode == LEFT || key == 'a' || key == 'A' )    left = false;
    if (keyCode == DOWN || key == 's' || key == 'S' )    down = false;
    if (keyCode == RIGHT || key == 'd' || key == 'D' )   right = false;
    if (key == ' ')                                      isShooting = false;
  }
  
  
  void drawCharacter(){
    if (hitTimer%2 ==0){
      pushMatrix();
      translate(this.pos.x, this.pos.y);
      translate(-280,-270);
      scale(0.7);
      strokeWeight(3);  
      stroke(#FFFFFF);
      int flameWiggle = 0;                     //flame
      if ( isMoving ){  
      fill(#F3AB3D);
      if ( random(1)>0.5 )  flameWiggle = 5;
      triangle(365,430,390,430,(380-flameWiggle),465);
      triangle(435,430,410,430,(420+flameWiggle),465);  }
      stroke(#DDDDDD);                         //center dark background
      fill(#1A1627);
        beginShape();
        vertex(380,365);
        vertex(420,365);
        vertex(450,410);
        vertex(410,450);
        vertex(390,450);
        vertex(350,410);
        vertex(380,365);
        vertex(420,365);
        endShape(CLOSE);
      stroke(#FFFFFF);                         //left and right back wing, RED
      fill(#CB0000);
      quad(347,375,370,350,370,455,347,467);
      quad(430,350,453,375,453,467,430,455);
      fill(#F3AB3D);
      ellipse(400,410,30,40);       
      fill(90,105,136);                        //left and right front deputy, GREY
      quad(365,320,350,310,350,375,365,355);
      quad(435,320,450,310,450,375,435,355);
      fill(gunColor,105,136);                  //center cannon
      if ( isShooting && gunColor<255 )  gunColor++;    else if (gunColor>90)  gunColor--;
        beginShape();
        vertex(380,400);
        vertex(420,400);
        vertex(420,335);
        vertex(407,312);
        vertex(393,312);
        vertex(380,335);
        endShape(CLOSE);
      popMatrix();
    }
    if ( gameState != 0 ){
    float maxLen = 50;
    float maxHeal = 10;
    float perentage = (float)this.health/(float)maxHeal;
    fill(255,0,0);
    noStroke();
    rect(80, height - 33, maxLen*perentage, 5);
    }
    
  }
  
}
