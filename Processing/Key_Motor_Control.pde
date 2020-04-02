import processing.serial.*;

Serial port;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

byte send[] = new byte[2];

int forwardBack = 0;
int leftRight = 0;

int now;
//int wait = 500;

void setup() {
  background(221);
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw() {

  if (leftPressed) {
    leftRight = 0;
  }

  else if (rightPressed) {
    leftRight = 180;
  }

  else if (upPressed) {
    forwardBack = 255;
  }

  else if (downPressed) {
    forwardBack = 21;
  }

  else {
    forwardBack = 0;
    leftRight = 90;
  }

  createSerial();
}

void keyPressed() {
  if (key == 'w') {
    upPressed = true;
  }
  else if (key == 's') {
    downPressed = true;
  }
  else if (key == 'a') {
    leftPressed = true;
  }
  else if (key == 'd') {
    rightPressed = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    upPressed = false;
  }
  else if (key == 's') {
    downPressed = false;
  }
  else if (key == 'a') {
    leftPressed = false;
  }
  else if (key == 'd') {
    rightPressed = false;
  }
}

void createSerial() {
  send[0] = byte(forwardBack/3);
  send[1] = byte(leftRight/2);
  println(send);
  port.write(send);
  /*if(millis()-now >= wait) {
    port.write(send);
    println(send);
    now = millis();
  }*/
}
