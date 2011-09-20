byte incomingByte;
byte controller;
byte value;
int output_1 = 3;
int output_2 = 5;
int output_3 = 6;
int output_4 = 9;
int output_5 = 10;
int output_6 = 11;
int statusLed = 13;
int action=2; 

void setup() {
  pinMode(statusLed,OUTPUT);   // declare the LED's pin as output
  pinMode(3,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  Serial.begin(31250);        
  digitalWrite(statusLed,HIGH);  
}

//loop: wait for serial data, and interpret the message
void loop () {
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if (incomingByte== 176){ // CONTROL CHANGE
      action=1;
    }
    else if ( (action==1)&&(controller==0) ){ // if recieve a control change, wait for which controller
      controller=incomingByte;
    }else if ( (action==1)&&(controller!=0) ){ // wait for value
      value=incomingByte;
      writeLights(controller, value);
      controller=0;
      value=0;
      action=0;
    }else{
    }
  }
}

void writeLights(byte controller, byte value){

  if (controller == 36)
  {
   analogWrite(output_1, value*2);
  }
  else if (controller == 37)
  {
    analogWrite(output_2, value*2);
  }
  else if (controller == 38)
  {
    analogWrite(output_3, value*2);
  }
  else if (controller == 39)
  {
    analogWrite(output_4, value*2);
  }
  else if (controller == 40)
  {
    analogWrite(output_5, value*2);
  }
  else if (controller == 41)
  {
    analogWrite(output_6, value*2);
  }
   

}

