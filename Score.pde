class Score{
  PFont scoreFont, msgFont, titleFont;
  float s, msgTimer;
  
  Score(float s){
    this.s = s;
    scoreFont = loadFont("ReckonerBold-48.vlw");
    msgFont = loadFont("AgencyFB-Bold-48.vlw");
    msgTimer = 0;
    //titleFont = loadFont("");
  }
  
  void update(){
    drawScore();
    if (msgTimer > 0)    msgTimer --;
  }
  
  void adjustScore(float amount){    //ADD SCORE >> if parameter given is postitive
    s += amount;               //LOWER SCOREE >> if para,eter given is negative
  }
  
  void drawScore(){
    fill(#FFFFFF);
    textFont(scoreFont,30);
    textAlign(CENTER);
    text("SCORE: " + (int)this.s, width/2, height - 20);
    text("HP: " + (int)player.health, 50, height - 20);
  }
  
  
  void message(String msg, float x, float y, float s){
    fill(#FFFFFF);
    textAlign(CENTER);
    textFont(msgFont,s);
    text(msg, x, y);
  }
  
  void title(String msg, float x, float y, float s){
    fill(#FFFFFF);
    textAlign(CENTER);
    textFont(msgFont,s);
    text(msg, x, y);
  }
  
  
}
