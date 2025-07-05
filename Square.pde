class Square{
  boolean exists = true;
  float xcor;
  float ycor;
  float width = 6;
  color c = #9b870c;
  color[] colors = {#ccb016,#eae46e,#edd44b,#e0c45e,#ddd35f,#e0b828,#f9ff5b,#f9e270,#f2de29};
  
  
  Square(float xcor_, float ycor_){
    int index = (int) random(0,colors.length);
    c = colors[index];
    xcor = xcor_;
    ycor = ycor_;
    
  }
  
  Square(float xcor_, float ycor_, float width_, color c){
    xcor = xcor_;
    ycor = ycor_;
    this.c = c;
    width = width_;
  }
  
  void setDead(){
    if(exists){
      exists = false;
      
    }
  }
  
  void setAlive(){
    if(!exists){
      exists = true;
    }
  }
  boolean isAlive(){
    return exists;
  }
  
  float getX(){
    return xcor;
  }
  
  float getY(){
    return ycor;
  }
  
  void resetY(int num){
    ycor = num;
  }
  
  void setY(int change){
    ycor += change;
  }
  
 void show(){
    
    if(exists){
      noStroke();
      fill(c);
      square(xcor,ycor,width);
    }
  }
  
  
  
  
  
  
}
