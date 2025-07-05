class Avatar{
  private boolean playerSide;
  int lives, xcor, ycor;
  float hitRadius;
 
  Avatar(int lives, boolean playerSide, int xcor, int ycor) {
    this.lives = lives;
    this.playerSide = playerSide;
    this.xcor = xcor;
    this.ycor = ycor;
    hitRadius = 40;
  }
 
  public int getLives(){
    return lives;
  }
 
  public void setLives(int live){
    lives = live;
  }
 
  public void setX(int x){
    xcor = x;
  }
 
  public int getX(){
    return xcor;
  }
 
  public void setY(int y){
    ycor = y;
  }
 
  public int getY(){
    return ycor;
  }
 
  public boolean returnSide(){
     return playerSide;
   }
 
  public float getRadius(){
    return hitRadius;
  }
  
  void loseLife(){
    if(lives>0){
    lives--;
  }
  }
  
}
