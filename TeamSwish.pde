import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*; 

PImage forearm;
PImage teamSwish;
int savedTime;
int totalTime = 1000;
float hello = 0.1;


ControlP5 cp5;
Slider forearmRotate;
Slider teamSwishRotate;
Slider forearmXCoordinates;
Slider forearmYCoordinates;
Slider teamSwishXCoordinates;
Slider teamSwishYCoordinates;
Button forearmStatic;
Button teamSwishStatic;
Button shoot;
Toggle tempo;
Slider tempoSpeedSlider;

float angle;
float counter;
boolean forearmBool = true;
boolean teamSwishBool = true;
boolean tempoOn = false;
boolean shot = false;


void setup() {
  size(1000, 600, P3D);
  background(255);
  forearm = loadImage("arm1.png");
  teamSwish = loadImage("TeamSwish.png");
  
  ac = new AudioContext();
  setupChime();
  setupTempo();
  counter = 0.0;

  cp5 = new ControlP5(this);
  
  shoot = cp5.addButton("shoot")
    .setPosition(30, 450)
    .setSize(250, 50)
    .activateBy(ControlP5.RELEASE);
    
  tempo = cp5.addToggle("Tempo")
    .setPosition(290, 450)
    .setSize(50, 50)
    .setLabel("Tempo Mode")
    .setColorLabel(0);
    
  tempoSpeedSlider = cp5.addSlider("TempoSpeed")
    .setPosition(350, 450)
    .setSize(100, 50)
    .setLabel("Tempo Speed")
    .setMin(3.0)
    .setMax(10.0)
    .showTickMarks(true)
    .setColorTickMark(0)
    .setColorLabel(0);

  forearmRotate = cp5.addSlider("Forearm Rotate")
    .setPosition(30, 100)
    .setSize(400, 30)
    .setRange(-40, 40)
    .setValue(0)
    .setColorForeground(color(0, 255, 0));
  ;

  teamSwishRotate = cp5.addSlider("TeamSwish Rotate")
    .setPosition(30, 300)
    .setSize(400, 30)
    .setRange(23, 125)
    .setValue(23)
    .setColorForeground(color(0, 255, 0));
  ;
  
  forearmStatic = cp5.addButton("Keep Forearm Static")
     .setValue(0)
     .setPosition(30, 150)
     .setSize(120, 50)
     .setColorBackground(color(0, 0, 255))
     .activateBy(ControlP5.PRESSED)
     ;
     
  teamSwishStatic = cp5.addButton("Keep TeamSwish Static")
     .setValue(0)
     .setPosition(30, 350)
     .setSize(120, 50)
     .setColorBackground(color(0, 0, 255))
     .activateBy(ControlP5.PRESSED)
     ;
     
  //Button Functionality
  forearmStatic.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.PRESSED):   
          cp5.getController("Forearm Rotate").setValue(0);
          if (forearmBool) {
            cp5.getController("Keep Forearm Static").setColorBackground(color(255, 0, 0));
            forearmBool = false;
          } else {
            cp5.getController("Keep Forearm Static").setColorBackground(color(0, 0, 255));
            forearmBool = true;
          }
          /*if (!forearmBool) {
            cp5.getController("Keep Forearm Static").setColorBackground(color(0, 0, 255));
            forearmBool = true;
          }*/
          break;
        case(ControlP5.RELEASED): 
          break;
      }
    }
  }
  );
  
  teamSwishStatic.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.PRESSED):   
          cp5.getController("TeamSwish Rotate").setValue(23);
          if (teamSwishBool) {
            cp5.getController("Keep TeamSwish Static").setColorBackground(color(255, 0, 0));
            teamSwishBool = false;
          } else {
            cp5.getController("Keep TeamSwish Static").setColorBackground(color(0, 0, 255));
            teamSwishBool = true;
          }
          break;
        case(ControlP5.RELEASED): 
          break;
      }
    }
  }
  );
  ac.start();
}//end setup

void shoot() {
  // convert LR and UD to -10 thru 10 int values
  int currLR = (int) (10 - 20 * (forearmRotate.getValue() - forearmRotate.getMin()) / (forearmRotate.getMax() - forearmRotate.getMin()));
  int currUD = (int) (10 - 20 * (teamSwishRotate.getValue() - teamSwishRotate.getMin()) / (teamSwishRotate.getMax() - teamSwishRotate.getMin()));
  status(currLR, currUD);
  shot = true;
}

void draw() {
  progressChime();
  
  //Forearm
  int w = -forearm.width/2;
  int h = -forearm.height/2 + 127;
  int wTS = -teamSwish.width/2;
  int hTS = -teamSwish.height/2;


  //Forearm
  float valueFX = cp5.getController("Forearm Rotate").getValue();
  float moveCoordinatesforTeamSwish = cp5.getController("Forearm Rotate").getValue();
  valueFX = valueFX * 0.01;  
  int x = 685;
  int y = 220;
  background(255);

  //TeamSwish
  float valueTSX = cp5.getController("TeamSwish Rotate").getValue();
  float moveCoordinatesforForearm = cp5.getController("TeamSwish Rotate").getValue();
  valueTSX = valueTSX * 0.01;  
  int xTS = 717;
  int yTS = 520;


  //TeamSwish
  pushMatrix();
  translate(xTS, yTS);
  rotateX(valueTSX);
  if (moveCoordinatesforTeamSwish <= 40 && moveCoordinatesforTeamSwish > 37) {
    wTS = wTS - 175;
    hTS = hTS + 65;
  }
  if (moveCoordinatesforTeamSwish <= 37 && moveCoordinatesforTeamSwish > 35) {
    wTS = wTS - 155;
    hTS = hTS + 60;
  }
  if (moveCoordinatesforTeamSwish <= 35 && moveCoordinatesforTeamSwish > 32) {
    wTS = wTS - 155;
    hTS = hTS + 60;
  }
  if (moveCoordinatesforTeamSwish <= 32 && moveCoordinatesforTeamSwish > 29) {
    wTS = wTS - 145;
    hTS = hTS + 65;
  }
  if (moveCoordinatesforTeamSwish <= 29 && moveCoordinatesforTeamSwish > 26) { 
    wTS = wTS - 145;
    hTS = hTS + 70;
  }
  if (moveCoordinatesforTeamSwish <= 26 && moveCoordinatesforTeamSwish > 23) {
    wTS = wTS - 140;
    hTS = hTS + 75;
  }
  if (moveCoordinatesforTeamSwish <= 23 && moveCoordinatesforTeamSwish > 20) {
    wTS = wTS - 130;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 20 && moveCoordinatesforTeamSwish > 17) {
    wTS = wTS - 120;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 17 && moveCoordinatesforTeamSwish > 14) {
    wTS = wTS - 110;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 14 && moveCoordinatesforTeamSwish > 11) {
    wTS = wTS - 100;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 11 && moveCoordinatesforTeamSwish > 8) {
    wTS = wTS - 90;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 8 && moveCoordinatesforTeamSwish > 5) {
    wTS = wTS - 80;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= 5 && moveCoordinatesforTeamSwish > 2) {
    wTS = wTS - 75;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= 2 && moveCoordinatesforTeamSwish > -1) {
    wTS = wTS - 70;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -1 && moveCoordinatesforTeamSwish > -4) {
    wTS = wTS - 65;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -4 && moveCoordinatesforTeamSwish > -7) {
    wTS = wTS - 50;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -7 && moveCoordinatesforTeamSwish > -10) {
    wTS = wTS - 48;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -10 && moveCoordinatesforTeamSwish > -13) {
    wTS = wTS - 40;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -13 && moveCoordinatesforTeamSwish > -16) {
    wTS = wTS - 30;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -16 && moveCoordinatesforTeamSwish > -19) {
    wTS = wTS - 20;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -19 && moveCoordinatesforTeamSwish > -22) {
    wTS = wTS - 10;
    hTS = hTS + 90;
  }
  if (moveCoordinatesforTeamSwish <= -22 && moveCoordinatesforTeamSwish > -25) {
    wTS = wTS + 0;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= -25 && moveCoordinatesforTeamSwish > -28) {
    wTS = wTS + 10;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= -28 && moveCoordinatesforTeamSwish > -31) {
    wTS = wTS + 10;
    hTS = hTS + 70;
  }
  if (moveCoordinatesforTeamSwish <= -31 && moveCoordinatesforTeamSwish > -34) {
    wTS = wTS + 30;
    hTS = hTS + 80;
  }
  if (moveCoordinatesforTeamSwish <= -34 && moveCoordinatesforTeamSwish > -37) {
    wTS = wTS + 30;
    hTS = hTS + 75;
  }
  if (moveCoordinatesforTeamSwish <= -37 && moveCoordinatesforTeamSwish >= -40) {
    wTS = wTS + 35;
    hTS = hTS + 70;
  }
  image(teamSwish, wTS, hTS);
  popMatrix();


  pushMatrix();
  translate(x, y);
  rotate(valueFX);
  if (moveCoordinatesforForearm <= 125 && moveCoordinatesforForearm > 120 && valueFX == 0) {
    w = w + 15;
    h = h - 15;
  }
  if (moveCoordinatesforForearm <= 120 && moveCoordinatesforForearm > 115 && valueFX == 0) {
    w = w + 17;
    h = h - 20;
  }
  if (moveCoordinatesforForearm <= 115 && moveCoordinatesforForearm > 110 && valueFX == 0) {
    w = w + 20;
    h = h - 30;
  }
  if (moveCoordinatesforForearm <= 110 && moveCoordinatesforForearm > 105 && valueFX == 0) {
    w = w + 20;
    h = h - 30;
  }
  if (moveCoordinatesforForearm <= 105 && moveCoordinatesforForearm > 100 && valueFX == 0) {
    w = w + 20;
    h = h - 32;
  }
  if (moveCoordinatesforForearm <= 100 && moveCoordinatesforForearm > 95 && valueFX == 0) {
    w = w + 20;
    h = h - 34;
  }
  if (moveCoordinatesforForearm <= 95 && moveCoordinatesforForearm > 90 && valueFX == 0) {
    w = w + 21;
    h = h - 36;
  }
  if (moveCoordinatesforForearm <= 90 && moveCoordinatesforForearm > 85 && valueFX == 0) {
    w = w + 21;
    h = h - 38;
  }
  if (moveCoordinatesforForearm <= 85 && moveCoordinatesforForearm > 80 && valueFX == 0) {
    w = w + 21;
    h = h - 40;
  }
  if (moveCoordinatesforForearm <= 80 && moveCoordinatesforForearm > 75 && valueFX == 0) {
    w = w + 21;
    h = h - 42;
  }
  if (moveCoordinatesforForearm <= 75 && moveCoordinatesforForearm > 70 && valueFX == 0) {
    w = w + 21;
    h = h - 44;
  }
  if (moveCoordinatesforForearm <= 70 && moveCoordinatesforForearm > 65 && valueFX == 0) {
    w = w + 21;
    h = h - 46;
  }
  if (moveCoordinatesforForearm <= 65 && moveCoordinatesforForearm > 60 && valueFX == 0) {
    w = w + 22;
    h = h - 48;
  }
  if (moveCoordinatesforForearm <= 60 && moveCoordinatesforForearm > 55 && valueFX == 0) {
    w = w + 23;
    h = h - 50;
  }
  if (moveCoordinatesforForearm <= 55 && moveCoordinatesforForearm > 50 && valueFX == 0) {
    w = w + 23;
    h = h - 50;
  }
  if (moveCoordinatesforForearm <= 50 && moveCoordinatesforForearm > 45 && valueFX == 0) {
    w = w + 23;
    h = h - 50;
  }
  if (moveCoordinatesforForearm <= 45 && moveCoordinatesforForearm > 40 && valueFX == 0) {
    w = w + 24;
    h = h - 50;
  }
  if (moveCoordinatesforForearm <= 40 && moveCoordinatesforForearm > 35 && valueFX == 0) {
    w = w + 25;
    h = h - 52;
  }
  if (moveCoordinatesforForearm <= 35 && moveCoordinatesforForearm > 30 && valueFX == 0) {
    w = w + 28;
    h = h - 52;
  }
  if (moveCoordinatesforForearm <= 30 && moveCoordinatesforForearm > 20 && valueFX == 0) {
    w = w + 29;
    h = h - 52;
  }
  image(forearm, w, h);
  popMatrix();




  //UI
  fill(0);
  textSize(20);
  text("Rotate Forearm", 30, 80);
  text("Rotate TeamSwish", 30, 280);
  textSize(12);
  text("TM", 205, 270);
  
  if (tempoOn && tempoVar <=0) {
    //play beep
    if (!shot) {
      badBeep.setToLoopStart();
      badBeep.pause(false);
      numBS++;
      //play bad beep
    } else {
     //play good beep
     goodBeep.setToLoopStart();
     goodBeep.pause(false);
     numGS++;
    }
    tempoVar = setTempo;
    shot = false;
  }
  if (tempoVar > 0) {
    tempoVar--;
  }
  
}//draw

void TempoSpeed(float value) {
 tempoSpeed = (int)value; 
  
}

void Tempo(boolean state) {
  if(state) {
    println("Tempo Mode Start.");
    //play start sound
    startTempo.setToLoopStart();
    startTempo.pause(false);
    shot = false;
    numGS = 0;
    numBS = 0;
    setTempo = TEMPOTIME * tempoSpeed;
    println("Tempo Chosen: " + tempoSpeed + "s");
    tempoVar = setTempo;
  }
  else {
    endTempo.setToLoopStart();
    endTempo.pause(false);
    println("Good Shots: " + numGS);
    println("Bad Shots: " + numBS);
    println("Ratio of Good Shots: " + 100.0*numGS/(numGS + numBS) + "%");
    
  }
  tempoOn = state;
}