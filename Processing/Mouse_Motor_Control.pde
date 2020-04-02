import controlP5.*;
import processing.serial.*;
Serial port;
ControlP5 cp5;
boolean motorDirection;              //true ccw, false cw, a true, b false
boolean motorOnOff;                  //true on, false off, c on, d off
int motorSpeed = 0;
float mouseXFloat;
float mouseYFloat;
int mouseXInt;
int mouseYInt;
int now;
int wait = 50;
int motorDirectionInt;
int motorOnOffInt;

void setup() {
  size(740, 350);
  cp5 = new ControlP5(this);

  cp5.addToggle("motorDirection")    //add toggle for the motor direction
  .setPosition(310, 280)
  .setSize(120, 60)
  .setValue(false)
  .setColorActive(#2A52B1)
  .setColorBackground(#2A52B1);

  cp5.addToggle("motorOnOff")        //add toggle to turn motor on or off
  .setPosition(310, 210)
  .setSize(120, 60)
  .setValue(true)
  .setColorActive(#696969)
  .setColorBackground(#2A52B1);

  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  if(motorDirection == true) {         //makes motor
    motorDirectionInt = 0;           //spin clockwise
  }
  if(motorDirection ==false) {         //makes motor
    motorDirectionInt = 1;           //spin counterclockwise
  }

  if(motorOnOff == false) {             //gets sent to arduino
    motorOnOffInt = 2;               //to turn motor on
  }
  if(motorOnOff == true) {            //gets sent to arduino
    motorOnOffInt = 3;               //to turn motor off
  }
  mouseXFloat = map(mouseX, 0, 740, 0, 180);
  mouseYFloat = map(-mouseY + 350, 0, 350, 0, 255);
  mouseXInt = int(mouseXFloat);
  mouseYInt = int(mouseYFloat);
  byte out[] = new byte[4];
  out[0] = byte(motorDirectionInt);
  out[1] = byte(motorOnOffInt);
  out[2] = byte(mouseYInt/3);
  out[3] = byte(mouseXInt/2);
  if(millis()-now >= wait) {
    println(out);
    port.write(out);
    now = millis();
  }
}
