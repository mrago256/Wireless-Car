#include <Servo.h>

const int controlPin1 = 2;
const int controlPin2 = 3;
const int enablePin = 5;
int currentValue = 0;
int values[] = {0,0,0,0};
int direction;
int onOff;
int speed;
int servoPos;
int incomingValue;
Servo servo;

void setup()  {
  pinMode (controlPin1, OUTPUT);
  pinMode (controlPin2, OUTPUT);
  pinMode (enablePin, OUTPUT);
  digitalWrite (enablePin, LOW);
  servo.attach(6);
  servo.write(90);
  Serial.begin(9600);
  Serial.setTimeout(0.5);
}

void loop() {
  if(Serial.available() > 0){
    incomingValue = Serial.read();
    values[currentValue] = incomingValue;
    currentValue++;
    if(currentValue > 3){
      currentValue = 0;
    }

    // after this point values[]
    // has the most recent set of
    // all values sent in from Processing
    //delay(40);

    direction = values[0];
    onOff = values[1];
    speed = values[2] * 3;
    servoPos = values[3] * 2;

    //Serial.println(servoPos + speed + onOff + direction);

    digitalWrite(controlPin1, LOW);
    digitalWrite(controlPin2, HIGH);

    Serial.println(servoPos);

    if(servoPos >= 105) {
      servo.write(servoPos);
    }
    else if(servoPos <= 75) {
      servo.write(servoPos);
    }
    else {
      servo.write(90);
    }

    if(direction == 0) {
      digitalWrite(controlPin1, LOW);
      digitalWrite(controlPin2, HIGH);
    }
    if(direction ==1) {
      digitalWrite(controlPin1, HIGH);
      digitalWrite(controlPin2, LOW);
    }
    if(onOff == 2) {
      analogWrite (enablePin, speed);
    }
    if(onOff ==3) {
      analogWrite (enablePin, 0);
    }
  }
}
