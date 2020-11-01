import processing.sound.*;
import java.util.Date;

int N_AGENTS;
Agent[] movers;
float MINFREQ= 1/60.0;
float MAXFREQ= 1/30.0;
float LIMITPAN=0.8;
float MINAMP=0.1; // -20 dB
float MINAXIS= 0;
float MAXAXIS= 0;
float MINRADIUS= 0;
float MAXRADIUS= 0;
float MAXDIST=0;
PVector center;
float t;
void setup(){
  size(720, 720);
  t=0;
  MINAXIS = 0.25*width/2;
  MAXAXIS = 0.95*width/2;
  MINRADIUS= 0.01*width;
  MAXRADIUS=20;
  MAXDIST=sqrt(2)*width/2;

  String path=sketchPath()+"/sounds";
  File dir = new File(path);
  print(dir.isDirectory());
  String filenames[] = dir.list();
  N_AGENTS=filenames.length;
  
  movers=new Agent[N_AGENTS];
  SoundFile sample;
  for(int i=0; i<N_AGENTS; i++){
     sample= new SoundFile(this, path+"/"+filenames[i]);
     movers[i]=new Agent(sample);
  }
  center=new PVector(width/2, height/2);
  background(0);
  
}

void draw(){
  rectMode(CORNER);
  fill(0,20);
  rect(0,0,width, height);
  t+=4/frameRate;
  color c= 255;
  for(int i=0; i<N_AGENTS; i++){
    movers[i].update(t);
    movers[i].draw(c); 
    break;
  }
}
