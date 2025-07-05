
class Wall{
  ArrayList<Square> Squares;
  float xcor;
  float ycor;
  Wall(float xcor_, float ycor_){
    xcor = xcor_;
    ycor = ycor_;
    Squares = new ArrayList<Square>();
  }
  public ArrayList<Square> getSquares(){
    return Squares; 
  }
  
  void constructFirstRow(){
    for(int i=1; i<13; i++){
      Squares.add(new Square(xcor+i*6,ycor));
    }
  }
  
  void constructFollowingRows(){
    for(int row=1; row<5; row++){
      for(int i=0; i<14; i++){
        Squares.add(new Square(xcor+i*6,ycor+row*6));
      }
    }
  }
  
  void constructSecondToLastRow(){
    Squares.add(new Square(xcor,ycor+6*5));
    Squares.add(new Square(xcor+1*6,ycor+6*5));
    Squares.add(new Square(xcor+13*6,ycor+6*5));
    Squares.add(new Square(xcor+12*6,ycor+6*5));
    
  }
  
  void constructLastRow(){
    Squares.add(new Square(xcor,ycor+6*6));
    Squares.add(new Square(xcor+13*6,ycor+6*6));
  }

  void show(){
    for(int i=0; i<Squares.size(); i++){
      Squares.get(i).show();
    }
  }
  
  
  
  
  
}
