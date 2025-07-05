import java.lang.Math; 
import java.util.ArrayList; 

class Enemy extends Avatar{
  int type;
  PImage enemy;
  int direction;
  int moveCounter = 0;
  float moveDownLimit;
  float width;
  float height;
  int RIGHTMOST_LIMIT; 
  int LEFTMOST_LIMIT; 
  int orgPausePoint = 72;
  int pausePoint = orgPausePoint;
  int pauseTimeMax = 144;
  int shootCounter = 200;
  int shootCounterMax;
  int LOWER_COOLDOWN = 300;
  int UPPER_COOLDOWN = 600;
  public float SHOOT_PROBABILITY ;
  
  ArrayList<Integer> S = new ArrayList<Integer>();
  
  int speed = 1;
  int speedIterator = 0; 
  
  int pauseTime = 0;
  int moveTime = 0;
  int jumps = 0;
  

  Enemy(int lives, boolean playerSide, int xcor, int ycor, float SHOOT_PROBABILITY_, int RIGHTMOST_LIMIT, int LEFTMOST_LIMIT, PImage enemy_){
    super(lives, playerSide, xcor, ycor);
    enemy = enemy_;
    SHOOT_PROBABILITY = SHOOT_PROBABILITY_;
    direction = 4;
    this.RIGHTMOST_LIMIT = RIGHTMOST_LIMIT; 
    this.LEFTMOST_LIMIT = LEFTMOST_LIMIT; 
    shootCounterMax = (int) random(LOWER_COOLDOWN,UPPER_COOLDOWN);

  }
  
  Enemy(int lives, boolean playerSide, int xcor, int ycor, float SHOOT_PROBABILITY_){
    super(lives,playerSide,xcor,ycor);
    SHOOT_PROBABILITY = SHOOT_PROBABILITY_;
  }
  
  void constructSeq(){
    S.add(1); 
    S.add(1); 
    S.add(2); 
    S.add(3); 
    S.add(5); 
    S.add(8); 
    S.add(13); 
    S.add(18); 
    S.add(24); 
    S.add(36); 
    S.add(50); 
    S.add(72); 
    S.sort(null);  
  }
  
  void show(){
    image(enemy,xcor,ycor);
    noFill();
    strokeWeight(2);
    //stroke(#FFFFFF);
    //ellipse(xcor+enemy.width/2,ycor+enemy.height/2, hitRadius, hitRadius);
    //fill(#FFFFFF);
    
  }
  
   void collision() { //void version of the dart code
    // Wall collisions
    for (Wall w : Walls) {
      for(int i=0; i<w.getSquares().size(); i++) {
        if (dist(super.getX()+this.width/2,super.getY()+this.height/2,w.getSquares().get(i).xcor+3, w.getSquares().get(i).ycor+3)<=super.getRadius()/2){
          if(w.getSquares().get(i).isAlive()){
            w.getSquares().get(i).setDead();
            //w.getSquares().remove(i);
            //i--;
          }
        }
      }
    }
    // Player collision
    if (dist(player.getX(), player.getY(), super.getX(), super.getY()) < player.getRadius()){
      player.loseLife();
      if(player.lives<=0){
        player.alive = false;
      }
    }
  }
  
  void move(){
    //textAlign(LEFT); 
    //textSize(25);
    //text("pausePoint: "+pausePoint,50,100);
    //text("moveTime: "+moveTime,50,150);
    //text("speed: "+speed,50,200);
    //text("jumps : "+jumps,50,250);
    //text("shootCounter: "+shootCounter,50,300);
    //text("shootCounterMax: "+shootCounterMax,50,350);
    if(moveTime<=pausePoint){
      if(direction==4){
         xcor+=speed;
      }
      if(direction==3){
        xcor-=speed;
      }
      moveTime++;
    //if(direction==4){
    //   xcor++;
    //}
    }
    if(xcor>=RIGHTMOST_LIMIT){
        if(moveCounter<50){
           direction = 0;
           ycor++;
           moveCounter++;
           jumps = 0;
         }
         else{
           moveTime = 0;
           moveCounter = 0;
           direction = 3;
           speedIterator++;
           speed = S.get(speedIterator); 
           pausePoint = orgPausePoint/speed; 
         }
      }
      else if(xcor<=LEFTMOST_LIMIT){
        if(moveCounter<50){
           ycor++;
           moveCounter++;
           direction = 0;
           jumps = 0;
         }
         else{
           moveTime = 0;
           moveCounter = 0;
           direction = 4;
           speedIterator++;
           speed = S.get(speedIterator); 
           pausePoint = orgPausePoint/speed; 
         }
         
      }
      else if(moveTime>=pausePoint){
        
        if(pauseTime<=pauseTimeMax){
          pauseTime++;
        }
        else{
          pauseTime = 0;
          moveTime = 0;
          jumps++;
        }
    }
   }
  
  
  void shoot(){

    if(shootCounter==shootCounterMax){
      Darts.add(new Dart(false, xcor+enemy.width/2,ycor+enemy.height/2+5));
      shootCounter = 0;
      shootCounterMax = (int) random(LOWER_COOLDOWN,UPPER_COOLDOWN);
    }
    shootCounter++;
    
  }
    
}
