class Player extends Avatar{
  PImage player;
  int move;
  boolean alive = true;
  int cooldown = 30;
  int width;
  int height;
  
  Player(int lives, boolean playerSide, int xcor, int ycor){
    super(lives, playerSide, xcor, ycor);
    move = 3;
    player = loadImage("player.png");
    player.resize(70,50);
    width = player.width;
    height = player.height;
  }
 
  public void move(int direction){
    if(direction == 0){
      if(super.getX() > 0){
      super.setX(super.getX() -move);
      }
    } else{
      if(super.getX() < 1700){
      super.setX(super.getX() +move);
      }
    }
  }
 
  void show(){
    if(alive){
      image(player, super.getX(), super.getY());
      cooldown++;
      strokeWeight(2);
      stroke(#FFFFFF);
      //noFill();
      //ellipse(xcor+player.width/2,ycor+player.height/2, hitRadius, hitRadius);
      
      
    }
    
  }
 
  
  public void shoot(){
    if(cooldown>=30){
      Darts.add(new Dart(true, super.getX()+player.width/2,super.getY()+player.height/2 - 5));
      cooldown=0;
    }
  }
  
  public float getRadius(){
    return hitRadius;
  }
}
