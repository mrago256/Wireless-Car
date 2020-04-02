#include <Servo.h>

const int driveDirection1 = 2;
const int driveDirection2 = 3;
const int onOff = 5;

int currentValue = 0;
int incomingSerial[] = {0, 0};
int incomingValue;
int servoPos;
int speed;

Servo servo;

void setup() {
  pinMode (driveDirection1, OUTPUT);
  pinMode (driveDirection2, OUTPUT);
  digitalWrite (onOff, LOW);
  servo.attach(6);
  servo.write(90);
  Serial.begin(9600);
  Serial.setTimeout(0.5);
}

void loop() {
  if(Serial.available() > 0) {
    incomingValue = Serial.read();
    incomingSerial[currentValue] = incomingValue;
    currentValue++;
    if (currentValue > 1) {
      currentValue = 0;
    }
  }

  speed = incomingSerial[0];
  servoPos = incomingSerial[1];

  //Serial.println (servoPos);
  //Serial.println (servoPos, speed);

  driveControl();
  servoControl();

}

void driveControl() {
  if (speed > -1 && speed < 1) {
    analogWrite (onOff, 0);
  }
  else if (speed > 80 && speed < 90) {
    digitalWrite (driveDirection1, LOW);
    digitalWrite (driveDirection2, HIGH);
    analogWrite (onOff, 255);
  }
  else if (speed > 5 && speed < 10) {
    digitalWrite (driveDirection1, HIGH);
    digitalWrite (driveDirection2, LOW);
    analogWrite (onOff, 80);
  }
}

void servoControl() {
  if (servoPos >= 85) {
    servo.write(145);
  }
  else if (servoPos <= 1) {
    servo.write(35);
  }
  else if (servoPos = 45) {
    servo.write(90);
  }
}
