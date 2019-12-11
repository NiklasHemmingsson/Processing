
//Importerar biblioteken Fisica för fysik och Minim för ljud
import fisica.*;
import ddf.minim.*;
Minim minim;

AudioSample laser1;     //Ljudfiler som används vid knapptryck på FCircle
AudioSample laser5;
AudioSample laser9;

int count = 0;          //Variabel som håller koll på vilket ljud som ska spelas vid knapptryck

FWorld world;           //Variabel för skapande av världen med fysikmotorn

PlayerKlass player1;    //Objekt med data från klassen PlayerKlass
Scoreboard score;       //Objekt med data från klassen Scoreboard
FCircle c;              //Använder oss av FCircle

PImage bg;              //Bakgrundsbild
PImage komet;           //Bild på komet
int bestestScore = 0;   //Sparar highscore

PFont font48;    //Deklarerar tre fonter
PFont font24;
PFont font18;

float value;    //variabel som används för att skicka impulsen i x-led till metoden Impulse under klassen PlayerKlass

void setup() {
  size(500, 800);
  bg = loadImage("spacegubbe.png");    //Laddar in bilderna
  komet = loadImage("komet.png");
  
  font24 = loadFont("NasalizationRg-Regular-24.vlw");       //Fonten Nasalization-Regular i tre olika storlekar
  font18 = loadFont("NasalizationRg-Regular-18.vlw");
  font48 = loadFont("NasalizationRg-Regular-48.vlw");
  
   //Laddar in ljuden
  minim = new Minim(this);      
  laser1 = minim.loadSample("laser1.mp3");
  laser5 = minim.loadSample("phaserDown2.mp3");
  laser9 = minim.loadSample("laser9.mp3");
  
  Fisica.init(this); //Här initierar vi fysikmotorn
  world = new FWorld(); //Här skapar vi en instans av klassen FWorld från Fisica biblioteket. FWorld håller reda på "världen" som ska simuleras och alla objekt som finns med.
  world.setEdges(); //Här ställer vi in att världen ska ha "kanter"
  //world.remove(world.top); //Så här tar man bort "taket" på världen
  world.setGravity(0, 1000); //Här sätter vi gravitationen på världen - prova att ändra!
 
  PImage p1_img = loadImage("gubbegubbe.png");//Här läser vi in en bild som vi vill skicka med när vi skapar en ny player-instans
  player1 = new PlayerKlass(width/2, height/4, 100, p1_img, "spelare1"); //Här skapar vi en instans av Klassen PlayerKlas och ger den en startposition, en storlek och en bild
  player1.setGrabbable(false); //Man ska inte kunna dra i spelaren. Vi vill endast kunna klicka på honom
  score = new Scoreboard(100, 100, 0); //Här skapar vi en instans av klassen Scoreboard, med position och startvärde
  
  //Skapar karaktären
  world.add(player1); 
}

void draw() {
  background(bg);             //Bakgrundsbild
  image(komet, -300, 380);    //Bilden på kometen
  world.step(); //Här stegar vi fram fysiksimulerinen et steg. Här körs alla matematiska beräkningar av hur objeken ska falla och studsa
  world.draw(); //Här ritas de nya positionerna för alla Fisica-objekten upp
  
  //om spelaren befinner sig på ett y-värde mindre än 740 ska vi skriva upp poängen
  if(player1.getY() < 740){
    score.display(); //Här anropar vi en metod i scoreboard klassen som ritar upp objektet. Eftersom scoreboarden är ett vanligt objekt och inte en del av Fisica objekten påverkas den inte av gravitation och ritas inte heller upp automatiskt
  }
  
  //Om spelaren befinner sig på botten av fönstret, utför nedanstående
  if(player1.getY() > 745){
    if(score.score > bestestScore){
      //Om nuvarande poängen är större än highscoret, sätt den nuvarande poängen som highscore
      bestestScore = score.score;
    } 
    //Resettar score
    score.score = 0;
      
    //Om man trycker på mellanslag flyttar vi positionen på spelaren uppåt och i mitten av skärmen.
    if(keyPressed){
      if(key == 32){
        player1.setPosition(width/2, height/4);
      }
    }
    else{
      //så länge man inte tryckt på mellanslag ska vi visa funktionerna gameOver och Display2
      //visar texten "press spacebar or space man to try again".
      player1.gameOver();
      //Visar highscore
      score.display2();
    }
  }
}

//Om man klickar på musen ska detta ske. 
void mousePressed(){
  //Om man klickar på vänster sida av karaktären, åk till höger
  if(mouseX  < player1.getX() -15 ){
    //Vi skapar variation i spelet genom att använda oss av randomvärden, men fortfarande åt riktningen som spelaren förväntar sig
    value = random(7000,10000);
  }
  //om man klickar i mitten av karaktären, åk rakt upp
  else if(mouseX > player1.getX() -15 && mouseX < player1.getX() + 15){
    value = 0;
  }
  //Om man klickar på höger sida av karaktären, åk till vänster
  else if (mouseX > player1.getX() + 15){
    value = random(-7000,-10000);
  }
  //Anropar metoden Impulse och skickar på med värdet på value.
  player1.Impulse(value);
  
}
