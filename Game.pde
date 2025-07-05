ArrayList<Dart> Darts = new ArrayList<Dart>();
ArrayList<Wall> Walls = new ArrayList<Wall>();
ArrayList<Enemy> Enemies = new ArrayList<Enemy>();
ArrayList<Saucer> Saucers = new ArrayList<Saucer>();
ArrayList<Square> Stars = new ArrayList<Square>();
float spec_y;
int ALIEN_SPACING = 60;
Player player;
boolean right, left; //shoot;
int XCOR = 600;
float SHOOT_PROBABILITY = 0.5;
PImage purpleAlien;
PImage greenAlien;
PImage yellowAlien;
PImage saucer;
boolean SAUCER_EXISTS;
float SAUCER_PROBABILITY = 0.3;
float SAUCER_COOLDOWN = 300;
float SAUCER_TICK = 0;
int score = 0;
int level;
int lastLevel = 3;
boolean startGame = false;
boolean gameStarted = false;
boolean gameEnded = false;
boolean playAgain = false;
boolean gameWon = false;
int HIGH_SCORE = score;

void setup() {
  size(1800, 1000);
  background(#000000);
  
  
  
}

void calculateHighScore(){
  if(score>HIGH_SCORE){
    HIGH_SCORE = score;
  }
}

void startGameBuild() {
  
  noStroke();
  level = 1;
  for (int i = 0; i < 200; i++) {
    Stars.add(new Square(random(1800), random(1000), 4, (int)random(255)));
    Stars.get(i).show();
  }
  purpleAlien = loadImage("purpleAlien.png");
  greenAlien = loadImage("GreenAlien.png");
  yellowAlien = loadImage("yellowAlien.png");
  saucer = loadImage("saucer.png");
  Wall wall1 = new Wall(XCOR - 42, 675);
  wall1.constructFirstRow();
  wall1.constructFollowingRows();
  wall1.constructSecondToLastRow();
  wall1.constructLastRow();

  Wall wall2 = new Wall(900- 42, 675);
  wall2.constructFirstRow();
  wall2.constructFollowingRows();
  wall2.constructSecondToLastRow();
  wall2.constructLastRow();

  Wall wall3 = new Wall(1800-XCOR - 42, 675);
  wall3.constructFirstRow();
  wall3.constructFollowingRows();
  wall3.constructSecondToLastRow();
  wall3.constructLastRow();
  // add walls
  Walls.add(wall1);
  Walls.add(wall2);
  Walls.add(wall3);
  //Player Start Position
  player = new Player(3, true, 900 - 35, 750);
  // test Dart collisions with Walls (complete)
  //Player player = new Player(3,#FFFFFF, true, 10,10);

  createEnemies(4 + level, 4 + level);
  for (Enemy e : Enemies) {
    e.constructSeq();
    e.show();
  }
  
  
  
}

void draw() {
  if (startGame) {
    if (gameStarted == false) {
      startGameBuild();
      gameStarted = true;
    }
    game();
  } else {
    textSize(150);
    fill(#00FF00);
    textAlign(CENTER);
    text("Space Invaders", 900, 350);
    noFill();
    stroke(#00FF00);
    strokeWeight(5);
    rect(750, 500, 300, 100);
    textSize(100);
    text("START", 900, 585);
    textAlign(LEFT);
  }
  
  
  //FOR TESTING WIN SEQUENCE
  //if(integer == 0){
  //  for(int i=0; i<Enemies.size(); i++){
  //    Enemies.remove(i);
  //    i--;
  //  }
    
  //  for(int i=0; i<Saucers.size(); i++){
  //    Saucers.remove(i);
  //    i--;
  //  }
  //}
  
  
  
  
  
}

void mousePressed() {
  if (!startGame && clickedStart()) {
    startGame = true;
  } else if (gameEnded == true && clickedPlayAgain()) {
    
    level = 1; //<-- MIGHT NOT BE NEEDED BUT INCLUDED FOR NOW
    
    for (int i=0; i<Enemies.size(); i++) {
      Enemies.remove(i);
      i--;
    }

    for (int i=0; i<Saucers.size(); i++) {
      Saucers.remove(i);
      i--;
    }

    for (Wall w : Walls) {
      for (Square s : w.getSquares()) {
        s.setAlive();
      }
    }
    while (Darts.size() > 0) {
      Darts.remove(0);
    }
    createEnemies(5, 5);
    for (Enemy e : Enemies) {
      e.constructSeq();
    }
    player = new Player(3, true, 900 - 35, 750);

  }
  
}

boolean clickedStart() {
  if (mouseX > 750 && mouseX < 1050 && mouseY > 500 && mouseY < 600) {
    return true;
  }
  return false;
}

boolean clickedPlayAgain() {
  if (mouseX > 650 && mouseX < 1150 && mouseY > 700 && mouseY < 820) {
    score = 0;
    return true;
  }
  return false;
  
}

void end() {
  textSize(200);
  fill(#FF0000);
  textAlign(CENTER);
  text("GAME OVER", 900, 600);
  noFill();
  stroke(#FF0000);
  strokeWeight(5);
  rect(650, 700, 500, 120);
  textSize(100);
  text("Play Again", 900, 785);
  textAlign(LEFT);
  gameEnded = true;
  //implement a "play again" option
}

void won(){
  textSize(200);
  fill(#00FF00);
  textAlign(CENTER);
  text("YOU WON", 900, 600);
  noFill();
  stroke(#00FF00);
  strokeWeight(5);
  rect(650, 700, 500, 120);
  textSize(100);
  text("Play Again", 900, 785);
  textAlign(LEFT);
  gameEnded = true;
}

void game() {

  frameRate(1000);
  background(0);
  calculateHighScore();
  textAlign(CENTER);
  textSize(45);
  fill(#FFFFFF);
  text("Level: "+level, 700, 50);
  text("Lives: "+player.lives, 900, 50);
  text("Score: "+score, 1100, 50);
  text("High Score: "+HIGH_SCORE, 1500, 50);
  textAlign(LEFT);
  

  if (player.lives == 0) {
    end();
  }
  
  if (level == 3 && Enemies.size() == 0 && Saucers.size() == 0){
    won();
  }

  //STARS
  for (int i = 0; i < 200; i++) {
    if (Stars.get(i).getY() > 1000) {
      Stars.get(i).resetY(0);
    } else {
      Stars.get(i).setY(1);
    }
    Stars.get(i).show();
  }
  //player
  player.show();
  //
  if (left) {
    player.move(0);
  }
  if (right) {
    player.move(1);
  }
  //if(shoot){
  //  player.shoot();
  //}
  // Enemies

  //SAUCER
  if (SAUCER_TICK==SAUCER_COOLDOWN) {
    if (Math.random()<=SAUCER_PROBABILITY) {
      Saucers.add(new Saucer(1, false, 0, 0, saucer, 0.8));
      SAUCER_PROBABILITY/=2;
      SAUCER_COOLDOWN*=2;
    }
    SAUCER_TICK = 0;
  }
  //fill(#FFFFFF);
  //textSize(25);
  //text("Saucer Tick: "+SAUCER_TICK, 50, 500);
  //text("Saucer Cooldown: "+SAUCER_COOLDOWN,50, 550);
  SAUCER_TICK++;
  for (int i=0; i<Saucers.size(); i++) {
    Saucer s = (Saucer) Saucers.get(i);
    //textSize(25);
    //text("saucer lives: "+s.getLives(),50,400);
    s.show();
    s.move();
    s.shoot();
    if (s.getX()>1800) {
      Saucers.remove(i);
    }
    //textSize(25);
    //text("saucer xcor :"+s.getX(), 50, 700);
  }
  //textSize(25);
  //text("#saucers: "+Saucers.size(), 50, 450);

  //display enemys
  for (Enemy e : Enemies) {
    if (e.speed == e.orgPausePoint) {
      noLoop();
      end();
    }
    e.show();
    e.move();
    if (Math.random()<(e.SHOOT_PROBABILITY)) {
      e.shoot();
    }
    e.collision();
  }
  // Display Walls
  for (Wall w : Walls) {
    w.show();
  }
  fill(#FFFFFF);
  //Display Darts - Collisions
  for (int i = 0; i < Darts.size(); i++) {
    Dart d = Darts.get(i);
    if (d.collision()) {
      Darts.remove(i);
      score += d.scoreIncrease;
    } else {
      d.show();
    }
  }
  //Game Over
  if (player.lives <= 0) {
    end();
  }
  //Levels
  if (Enemies.size() == 0 && Saucers.size() ==0 && level < lastLevel) {
    for (Wall w : Walls) {
      for (Square s : w.getSquares()) {
        s.setAlive();
      }
    }

    SAUCER_PROBABILITY = 0.3;
    SAUCER_COOLDOWN = 300;
    SAUCER_TICK = 0;
    level++;
    player.lives = 3;
    if (level == 2) {
      while (Darts.size() > 0) {
        Darts.remove(0);
      }
      createEnemies(4 + level, 4 + level);
      for (Enemy e : Enemies) {
        e.constructSeq();
      }
    }
    if (level == 3) {
      while (Darts.size() > 0) {
        Darts.remove(0);
      }
      createEnemies(4 + level, 4 + level);
      for (Enemy e : Enemies) {
        e.constructSeq();
      }
    }
  }
}

void createEnemies(int num_rows, int num_cols){
  for(int i=0; i< num_cols; i++){
    for(int j =0; j < num_rows; j++){
      if(j>=3){
        Enemies.add(new Enemy(1, false, XCOR+ALIEN_SPACING*i, 100 + ALIEN_SPACING * j, 0.3, ALIEN_SPACING*i + 1800 - XCOR - num_cols*ALIEN_SPACING + 42 + 20, ALIEN_SPACING*i+ XCOR-42,purpleAlien));
      }
      else if(j>=1){
        Enemies.add(new Enemy(1, false, XCOR+ALIEN_SPACING*i, 100 + ALIEN_SPACING * j, 0.4, ALIEN_SPACING*i + 1800 - XCOR - num_cols*ALIEN_SPACING + 42 + 20, ALIEN_SPACING*i+ XCOR-42,greenAlien));
      }
      else if(j==0){
        Enemies.add(new Enemy(1, false, XCOR+ALIEN_SPACING*i, 100 + ALIEN_SPACING * j, 0.5, ALIEN_SPACING*i + 1800 - XCOR - num_cols*ALIEN_SPACING + 42 + 20, ALIEN_SPACING*i+ XCOR-42,yellowAlien));
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = true;
    } else if (keyCode == RIGHT) {
      right = true;
    }
  }
  if (key == ENTER) {
    //textSize(25);
    //text("test", 50, 50);
    player.shoot();
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = false;
    } else if (keyCode == RIGHT) {
      right = false;
    }
  }
  //if(key == ENTER){
  //  shoot = false;
  //}
}
