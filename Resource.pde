class Resource{
  PVector pos;
  int type, boostTimer, loadT,stayT = -1;    //type 0: Health, type 1: speed
  Score msg;
  
  Resource(){
    pos = new PVector(random(50, width-50), random(50, height-50));
    msg = new Score(5*60);
    loadT = 60;
  }
  
  void update(){
    println(type,"loading:",loadT,  "stay:", stayT);
    resourceTimerUpdate();
    checkPickup();
    drawResource();
  }
  
  void resourceTimerUpdate(){    //default 30 second queue time > 5 second resouce avaliable
    if (type == 0){
      stayT = 0;
      loadT --;
      if (loadT == 0){    stayT = 3*60;    type = (int)random(1,3);    pos = new PVector(random(50, width-50), random(50, height-150));}
    }
    if (type != 0){
      loadT = 0;
      stayT --;
      if (stayT == 0){    loadT = 5*60;    type = 0;}
    }
    
    if (boostTimer>0)     boostTimer--;
    
    if (boostTimer==0){   
        player.speedBoost = 1.5;      BG = #2D3E50;      
      }
  }
  
  void checkPickup(){
    boolean pickuped = ( dist(this.pos.x, this.pos.y, player.pos.x, player.pos.y) < player.cWidth + 15*2 );
    if (pickuped && type == 1){
      player.health += 3;
      type = 0;
      loadT = 5*60;
      }
    if (pickuped && type == 2){
      player.speedBoost = 2.5;
      for (int i=0; i<enemies.size(); i++)     enemies.get(i).vel.mult(0.5);
      BG = #005387;
      boostTimer = 120;
      type = 0;
      loadT = 5*60;
    }  
  }

  
  void drawResource(){
    switch(type){
    case 0:
      float maxLen = 100;
      float maxLoadTime = 5*60;
      float perentage = (float)this.loadT/(float)maxLoadTime;
      fill(#FFFFFF);
      noStroke();
      rect(width, height - 33, -maxLen*perentage, 5);
      msg.message("Resource loading...", width-80, height - 40, 20);
      break;
    case 1:
      pushMatrix();
      translate(pos.x, pos.y);
      fill(#CB0000);
      noStroke();
      rect(-10, -5, 20, 10);
      rect(-5, -10, 10, 20);
      popMatrix();
      break;
    case 2:
      pushMatrix();
      translate(pos.x, pos.y);
      fill(#F3AB3D);
      noStroke();
      triangle(0,-10, -10,5, 10,5);
      popMatrix();
      break;
    }
  }
  
  
}
