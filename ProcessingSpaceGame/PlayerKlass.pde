
class PlayerKlass extends FCircle { //se ovan - Prova att ändra så att klassen i stället ärver från FBox för en fyrkant, eller Fcompound eller FBlob
 
  float circleRadius = 50;

  //Det här är klassens KONSTRUKTOR. Den metoden anropas alltid när en ny INSTANS skapas av klassen genom anropet new PlayerKlass(30, 30, 40)  
  PlayerKlass(int startX, int startY, int size, PImage img, String name) { 
    super(size); //Här anropar vi konstruktorn som vi har ÄRVT från FCircle - den vill ha diametern på cirkeln som parameter (se http://www.ricardmarxer.com/fisica/reference/fisica/FCircle.html)
    img.resize(size, size);
    this.setName(name);     //kan ge den ett namn, nu blir det "spelare1" men det använder vi inte 
    this.attachImage(img); //här klistrar vi en bild på cirkeln
    this.setNoStroke();
    //Här placerar vi spelarfiguren på den position som skickas med till konstruktorn när vi skapar ett nytt objekt
    this.setPosition(startX, startY); //här anropar vi en metod som vår nya klass har ÄRVT av klassen FCircle - När vi skriver ovan att PlayerKlass extend FCircle, betyder det att vi ärver alla FCircles klasser 
  }

  //variabeln value som vi skickade med tilldelas till float xDirection
  void Impulse(float xDirection){
    //Villkor som kollar om spelaren klickar inuti FCircle.
    //om distansen från origo till muspekaren är mindre än circleRadius, alltså 50, ska vi spelaren en impulse
    if(dist(mouseX, mouseY, player1.getX(), player1.getY()) < circleRadius){
         
           //Anger impulsen
           this.addImpulse(xDirection,-20000);
           //Vi anropar metoden increaseScore() för att öka poängen med ett för varje knapptryck på karaktären
           score.increaseScore();
            
            //Första gången man klickar spelar laser1 upp m.h.a. trigger();
            if(count == 0){
             laser1.trigger();
            }
            //Andra klicket
            if(count == 1){
             laser5.trigger();
            }
            //Tredje klicket
            if(count == 2){
             laser9.trigger();
            }
            //Vi använder oss endast av tre ljud, därför startar vi om count efter det tredje klicket så vi kan spela upp ljuden igen. 
            if(count < 2){
              count++;
            }
            else {
              count = 0;
            }
       }
   }
   
   //Text som visas när spelaren befinner sig på y > 745.
   void gameOver(){ 
     textFont(font18);
     textAlign(CENTER); 
     fill(255);
     text("Press spacebar or spaceman to try again!", 250, 250);
     
   }


   
   
}



 
 
