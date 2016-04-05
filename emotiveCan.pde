import processing.serial.*;

PImage img;
PImage happy;
PImage sad;
PImage surprise;
PImage thought;
int a; 
float mx;
float my;
float easing = 0.5;
float esize = 45;
int cigCount = 99;
int groundCount = 0;
int faceX = 300;
int faceY = 180;
int faceW = 1162/2;
int faceH = 1195/2;
int helperCount = 79;

//Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

void setup() {
  fullScreen();
  noStroke(); 
  noCursor();
  smooth();
  ellipseMode(RADIUS);  

  // Images must be in the "data" directory to load correctly
  happy = loadImage("animal-happy.png");
  sad = loadImage("animal-sad.png");
  surprise = loadImage("animal-surprise.png");
  thought = loadImage("trash.png");

  img = happy;
  
  //print(Serial.list());
  //String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  //myPort = new Serial(this, portName, 9600); 

}

void addCig(){
  // cig added to can
  cigCount++;
  makeHappy();
}

void ignoreTray(){
  // user ignores can & drops cig on ground
  makeSad();
}

void makeHappy(){
  img = happy;
}

void makeSad(){
  img = sad;
}

void draw() {
  // clear
  background(255);
  
  // draw face bg
  image(img, faceX, faceY, 1162/2, 1195/2);
  
  int eyeH = 100;
  int eyeW = 70;
  int eye1X = 160 + faceX;
  int eye2X = 330 + faceX;
  int eyeY = 200 + faceY;
  
  // eyes follow the target
  int targetX = mouseX;
  int targetY = mouseY;
    if(abs(targetX - mx) > 0.1) {
      mx = mx + (targetX - mx) * easing;
    }
    if(abs(targetY - my) > 0.1) {
      my = my + (targetY- my) * easing;
    }
        
    float mx1 = constrain(mx, eye1X, eye1X+eyeW); // eye 1
    float my1 = constrain(my, eyeY, eyeY+eyeH);  // eye 1
    float mx2 = constrain(mx, eye2X, eye2X+eyeW); // eye 2
    float my2 = constrain(my, eyeY, eyeY+eyeH);  // eye 2
    
    fill(0);
    ellipse(mx1, my1, esize, esize);
    ellipse(mx2, my2, esize, esize);
    
    // draw cig counter
    textSize(50);
    fill(0, 102, 153);
    text("trash eaten:" + str(cigCount), 10, 50);
    text("number of helpers:" + str(helperCount), 10, 100);
    text("trash spotted:" + str(groundCount), 950, 50);
    
    handleKeyPress();
    
    // handle sensor
    //if ( myPort.available() > 0) 
    //{  // If data is available,
    //  val = myPort.readStringUntil('\n');         // read it and store it in val
    //  addCig();
    //} 

}

void trashSpotted(){
  img = surprise;
  groundCount++;
}

void handleKeyPress() {
  if (keyPressed) {
    if (key == 'h' || key == 'H') {
      makeHappy();
    } else if(key == 's' || key == 'S'){
      makeSad();
    } else if(key == 'r' || key == 'R'){
      img = surprise;
    } else if (key == '1'){
      trashSpotted();
    } else if (key == '2'){
      ignoreTray();
    } else if (key == '3'){
      makeSad();
      image(thought, faceX+faceW-20, faceY-100, 221*2, 228*2);

    } else if (key == '4'){
      addCig();
      helperCount++;
      groundCount--;
    }
  } 
}