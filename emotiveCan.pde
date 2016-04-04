PImage img;
PImage happy;
PImage sad;
int a; 
float mx;
float my;
float easing = 0.5;
float esize = 45;

void setup() {
  fullScreen();
  noStroke(); 
  smooth();
  ellipseMode(RADIUS);  

  // Images must be in the "data" directory to load correctly
  img = loadImage("face-neutral.png");
  happy = loadImage("animal-happy.png");
  sad = loadImage("animal-sad.png");
}

void makeHappy(){
  img = happy;
}

void makeSad(){
  img = sad;
}

void draw() {
  //image(img, 0, 0);
  background(255);
  image(img, 0, 0, 1162/2, 1195/2);
  
  int eyeH = 100;
  int eyeW = 70;
  int eye1X = 160;
  int eye2X = 330;
  int eyeY = 200;
  
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
    
    handleKeyPress();
}

void handleKeyPress() {
  if (keyPressed) {
    if (key == 'h' || key == 'H') {
      makeHappy();
    } else if(key == 's' || key == 'S'){
      makeSad();
    }
  } 
}