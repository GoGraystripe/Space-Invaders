class Dart{
  boolean team;
  int x;
  int y;
  int cooldown = 25;
  int scoreIncrease = 0; 

  public Dart(boolean team, int x, int y){
    this.team = team;
    this.x = x;
    this.y = y;
   
  }
 
  void show(){
    rect(x, y, 4, 20);
    if (team == true){
      y -= 3;
    }
    else {
      y += 3;
    }
  }
  
  void scoreIncreaseUpdater(Enemy e){
    if (e.enemy == purpleAlien){
      scoreIncrease = 10; 
    }
    else if (e.enemy == greenAlien){
      scoreIncrease = 20; 
    }
    else if (e.enemy == yellowAlien){
      scoreIncrease = 30;
    }
  }
  
  boolean collision() {
    // Wall collisions
    for (Wall w : Walls) {
      for(int i=0; i<w.getSquares().size(); i++) {
        if ((x <= w.getSquares().get(i).getX() + 10 && x >= w.getSquares().get(i).getX()) && (y <= w.getSquares().get(i).getY() + 10 && y >= w.getSquares().get(i).getY())){
          if(w.getSquares().get(i).isAlive()){
            w.getSquares().get(i).setDead();
            //w.getSquares().remove(i);
            //i--;
            return true;
          }
        }
      }
    }
    // Avatar collisions
    if (team) {
      for (int i = 0; i < Enemies.size(); i++){
        Enemy enemy = (Enemy) Enemies.get(i);
        if (dist(enemy.getX()+enemy.width/2, enemy.getY()+enemy.height/2, x, y) < enemy.getRadius()) {
          enemy.loseLife();
          if(enemy.lives<=0){
            Enemies.remove(i);
            scoreIncreaseUpdater(enemy); 
            i--;
          }
          
          return true;
        }
      }
      for(int i=0; i< Saucers.size(); i++){
        Saucer saucer = (Saucer) Saucers.get(i);
        
        
        if (dist(saucer.getX()+saucer.width/2, saucer.getY()+saucer.height/2, x, y) < saucer.getRadius()) {
          
          saucer.loseLife();
          
          if(saucer.lives<=0){
            Saucers.remove(i);
            score+=1000;
            i--;
          }
          
          return true;
        }
      }
    }
    else {
      if (dist(player.getX()+player.width/2, player.getY()+player.height/2, x, y) < player.getRadius()){
        player.loseLife();
        player.setX(900 - 35); 
        if(player.lives<=0){
          player.alive = false;
        }
        return true;
      }
    }
    return false;
  }
}
