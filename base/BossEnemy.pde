class BossEnemy extends BasicEnemy{
  
  ArrayList<Projectile> bombs = new ArrayList<Projectile> ();
  float bombTimer, angle;
  
  BossEnemy(PVector pos, PVector vel, float h){
    super(pos, vel, h);
    super.cWidth = 100;
    super.cHeight = 100;
    super.scale = 1.5;
    super.health = 5;
    super.colour = #F3AB3D;
    super.type = 1;
    bombTimer = 30;
  }
  
  void update(){
    checkState();
    moveCharacter();
    drawCharacter();
    checkHitPlayer();
    checkProjectile();
    checkWalls(1);
    fire();  
  }
  
  void fire(){
    if (bombTimer > 0)    bombTimer--;
    
    if (bombTimer == 1){
      if ( random(1)>0.6 ){   
          Projectile bomb = new Projectile( pos.copy(), new PVector(0,5), 2, 1);         
          bombs.add(bomb);}
      else{                   
          Projectile bomb = new Projectile( pos.copy(), new PVector(0,10), 2, 0);            
          bombs.add(bomb);}

      bombTimer = 45;         //shoot every 1.5 second
      }
    
  }
  
  void checkProjectile(){     //check if Boss's bomb hit an enemy    
    for (int i=0; i<bombs.size(); i++){
       Projectile currBomb = bombs.get(i);
       currBomb.update();         
          if ( currBomb.hitCharacter(player) && player.health>0 ){    
            player.decreaseHealth(1);
            bombs.remove(currBomb);
          }
    }
    if (enemies.size() == 0)    bombs.clear();
  }
  
  void checkHitPlayer(){    //check if enemy hit player. if hit, player lose hp
    if ( hitCharacter(player) ){
      player.decreaseHealth(1);
      resolveCollision();
    }      
  } 
  
  
  
}
