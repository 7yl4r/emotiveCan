


const int flexpin = 0; 
const int epsilon = 10;
int lastNumber = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int flexposition;    // Input value from the analog pin.

  // Read the position of the flex sensor (0 to 1023):
  flexposition = analogRead(flexpin);

  if(lastNumber - flexposition > epsilon || flexposition- lastNumber > epsilon) {
    lastNumber = flexposition;
    Serial.print("sensor: ");
    Serial.print(flexposition);
    Serial.print("\n");
    delay(2000);
  }

  delay(20); 
  
}
