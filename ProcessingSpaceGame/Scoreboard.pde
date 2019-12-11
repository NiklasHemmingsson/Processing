class Scoreboard {

//Här är klassens variabler. De kallas ibland för TILLSTÅNDSVARIABLER
  int score;
  int positionX;
  int positionY;
 
  //Konstruktormetoden
  Scoreboard(int posx, int posy, int initialscore) { //Konstruktorn tar emot tre parametrar
    //Här sätter vi värden på klassens tillståndsvariabler
    positionX = posx;
    positionY = posy;
    score=initialscore;
  }
  
  //Metod som ökar poängen med 1.
  void increaseScore() { 
    score++;
  }

//rita upp poängtavlan
  void display() {
    textFont(font48);
    textAlign(CENTER);
    fill(255);
    text(score, 250, positionY+55);
  }
  
  //ritar upp highscore. Snyggt metodnamn jag vet
  void display2(){
    textFont(font24);
    textAlign(CENTER);
    fill(255);
    text("Current Best Score: "+ bestestScore, 250, positionY);
  }

}
