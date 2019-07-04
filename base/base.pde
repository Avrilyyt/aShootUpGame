
Player player;
Score score;
Resource resource;
int gameState = 0, num = 5, timer = -1;
ArrayList<BasicEnemy> enemies = new ArrayList<BasicEnemy>();
color BG = #2D3E50;


void setup(){
  size(700,960);
  player = new Player(new PVector(width/2,height/2+200), new PVector(0, 0), 20);
  for (int i=0;i<num;i++) {
    enemies.add(new BasicEnemy( new PVector( random(width),random(-200)), new PVector(0, random(2)), 3));
  }
  score = new Score(0);
  resource = new Resource();
  gameState = 0;
}

void draw(){
  background(BG);  
  updateGameState();  
}


void updateGameState(){
  switch(gameState){
    case 0:                 //Welcome Screen
      enemies.clear();
      score.message("READY?", width/2, height/2-50, 50);
      score.message("Press ENTER key to start...", width/2, height/2+30, 30);
      score.message("Author: Avril Yang", width/2, height-50, 20);
      player.update();
      break;
    case 1:                 //In Game. Normal level. Basic Enemies only.
      player.update();  
      for (int i=0; i<enemies.size(); i++)     enemies.get(i).update();     
      score.update();
      resource.update();
      num = 10;
      if ( enemies.size() < num ){
        enemies.add(new BasicEnemy( new PVector( random(width),random(-100)), new PVector(0, random(0.5,5)), 3)); 
      }
      if ( score.s > 1 ){                     enemies.clear();    score.msgTimer = 60;    gameState = 2;
                                               enemies.add(new BossEnemy( new PVector( random(150,width-150),150), new PVector(random(3), random(3)), 8));}
        break;
    case 2:                //In Game. Boss level. Boss Enemies only.
      num = 2;
      player.update();
      for (int i=0; i<enemies.size(); i++)     enemies.get(i).update();
      if ( score.msgTimer > 0 )                score.message("BOSS appears!", width/2, height/2, 30);      
      score.update();
      resource.update();
      if ( enemies.size() == 0 ){              score.msgTimer = 120;    gameState = 3;
                                               enemies.add(new BossEnemy( new PVector( random(150,width-150),150), new PVector(random(3), random(3)), 8));}
                                          
      break;
    case 3:                //In Game. Final level. Basic Enemies 
      num = 5;
      player.update();  
      if ( enemies.size() < num )              enemies.add(new BasicEnemy( new PVector( random(width),random(-100)), new PVector(random(3), random(3)), 3));                                
      for (int i=0; i<enemies.size(); i++){    enemies.get(i).trackPlayer = true;    enemies.get(i).update();}
      if ( score.msgTimer > 0 )                score.message("Waves of Enemies appear!", width/2, height/2, 30);   
      score.update();
      resource.update();
      if ( score.s >= 30 ){                    enemies.clear();    score.msgTimer = -1;    gameState = 9;}
      break;
    case 9:                //Game End. Player WIN.
      enemies.clear();
      score.message("YOU WIN!!", width/2, height/2-50, 60);
      score.message("Press ENTER to replay!", width/2, height/2+30, 30);
      score.message("Score:"+str((int)score.s), width/2, height/2+100, 20);  
      score.message("Author: Avril Yang", width/2, height-50, 20);
      break;
    case -1:              //Game End. Player LOST  
      enemies.clear();
      score.message("GAME OVER", width/2, height/2-50, 60);
      score.message("Press ENTER to retry...", width/2, height/2+30, 30);
      score.message("Score:"+str((int)score.s), width/2, height/2+100, 20);
      score.message("Author: Avril Yang", width/2, height-50, 20);
      if ( keyPressed && keyCode == ENTER )    gameState = 1;
      break;
    }
}

void keyPressed() {
  if ( gameState != 0)    player.checkKeyPressed();
  
  if ( keyCode == ENTER && gameState == 0 )    gameState = 1;
  
  if ( gameState == -1 || gameState == 9 ){
    if ( keyCode == ENTER ){
      score.s = 0;
      player.pos = new PVector(width/2,height/2+200);
      player.health = 10;
      gameState = 1;}
  }
}

void keyReleased() {
  player.checkKeyReleased();
}
