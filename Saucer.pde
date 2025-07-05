class Saucer extends Enemy{
  int lives;
  boolean playerSide;
  int START_X;
  float X_SPEED = 3;
  float Y_SPEED = 2; //POSITIVE VALUE
  float Y_ACCELERATION = -0.005; //NEGATIVE VALUE
  int hitRadius = 80;
  int shootCounter;
  int shootCounterMax = 30;
  int LOWER_COOLDOWN = 20;
  int UPPER_COOLDOWN = 40;
  PImage saucer;
  
  Saucer(int lives_, boolean playerSide_, int xcor_, int ycor_, PImage saucer_, float SHOOT_PROBABILITY_){
     super(lives_, playerSide_, xcor_, ycor_, SHOOT_PROBABILITY_);
     START_X = xcor_;
     saucer = saucer_;
     
  }
  
  void shoot(){

    if(shootCounter==shootCounterMax){
      Darts.add(new Dart(false, xcor+saucer.width/2,ycor+saucer.height/2+5));
      shootCounter = 0;
      shootCounterMax = (int) random(LOWER_COOLDOWN,UPPER_COOLDOWN);
    }
    shootCounter++;
    
  }
  
  
  
  void move(){
    if(START_X==1800){
      xcor-=X_SPEED;
      
    }
    else if(START_X==0){
      xcor+=X_SPEED;
    }
    ycor+=Y_SPEED;
    Y_SPEED+=Y_ACCELERATION;
    //textSize(25);
    //text("speed: "+Y_SPEED,50,600);
  }
  
  void show(){
    image(saucer,xcor,ycor);
    //noFill();
    //strokeWeight(2);
    //stroke(#FFFFFF);
    //ellipse(xcor+saucer.width/2,ycor+saucer.height/2, hitRadius, hitRadius);
    //fill(#FFFFFF);
  }
  
}
