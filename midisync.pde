

byte incomingByte;
byte note;
byte velocity;


int statusLed = 13;   // select the pin for the LED

int action=2; //0 =note off ; 1=note on ; 2= nada


//setup: declaring iputs and outputs and begin serial
void setup() {
  pinMode(statusLed,OUTPUT);   // declare the LED's pin as output
  pinMode(2,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);

  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  
  //start serial with midi baudrate 31250 or 38400 for debugging
  Serial.begin(31250);        
  digitalWrite(statusLed,HIGH);  
}

//loop: wait for serial data, and interpret the message
void loop () {
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // wait for as status-byte, channel 1, note on or off
    if (incomingByte== 176){ // note on message starting starting
      action=1;
    }else if (incomingByte== 128){ // note off message starting
      action=0;
    }else if (incomingByte== 208){ // aftertouch message starting
       //not implemented yet
    }else if (incomingByte== 160){ // polypressure message starting
       //not implemented yet
    }else if ( (action==0)&&(note==0) ){ // if we received a "note off", we wait for which note (databyte)
      note=incomingByte;
      playNote(note, 0);
      note=0;
      velocity=0;
      action=2;
    }else if ( (action==1)&&(note==0) ){ // if we received a "note on", we wait for the note (databyte)
      note=incomingByte;
    }else if ( (action==1)&&(note!=0) ){ // ...and then the velocity
      velocity=incomingByte;
      playNote(note, velocity);
      note=0;
      velocity=0;
      action=0;
    }else{
      //nada
    }
  }
}

void blink(){
  digitalWrite(statusLed, HIGH);
  delay(100);
  digitalWrite(statusLed, LOW);
  delay(100);
}


void playNote(byte note, byte velocity){

  if (note == 36)
  {
   analogWrite(6, velocity*2);
  }
  if (note == 37)
  {
    analogWrite(5, velocity*2);
  }
   

}

