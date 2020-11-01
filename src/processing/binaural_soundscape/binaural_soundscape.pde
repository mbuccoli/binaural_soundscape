import processing.sound.*;
import java.util.Date;

// PARAMETERS//
boolean IMPORT_JSON=true; // true and imports the values from a json file (creates it if it does not exist)
float MINFREQ= 1/60.0; // minimum frequency to get a full orbit 1/(orbit duration)
float MAXFREQ= 1/30.0;  // maximum frequency to get a full orbit 1/(orbit duration)
float OPACITY_BACKGROUND=100; // opacity of the final background
float LIMITPAN=0.99; // maximum amount of pan, from 0 (alwyas centerd) to 1 (full range of pan)
float MINAMP=0.1; // minimum aplitude, corresponds to -20 dB
float MIN_BRIGHTNESS=100; // minimum level of brightness when the sample is far from the center
float MIN_SATURATION=150; // minimum level of saturation when the sample is far from the center
float MINAXIS_FACTOR=0.35; // scale w.r.t. the width to the orbit size
float MAXAXIS_FACTOR=0.95; // scale w.r.t. the width to the orbit size
float MIN_PHASE_DIFF=PI/4; // minimum difference between the phases; if 0 lines are allowed 
float MAXRADIUS=20; // maximum radius size for the agents
float MIN_HUE=0; // select a hue sector by setting minimum/maximum hue. if you want to take betweek 240 and 20, use MIN_HUE=240 and MAX_HUE=20
float MAX_HUE=255; // select a hue sector by setting minimum/maximum hue. if you want to take betweek 240 and 20, use MIN_HUE=240 and MAX_HUE=20
float MINRADIUS_FACTOR=0.01; // minimum radius w.r.t. the width of the window
float CENTER_RADIUS=100; // radius of the element in the center


float MINRADIUS;
float MINAXIS;
float MAXAXIS;
float MAXDIST;
PVector center;
float t;

ArrayList<Agent> movers;
String json_fn="data/config.json";

void createDefaultJSON(){
  JSONObject json= new JSONObject();
  json.setFloat("MINFREQ", 1/60.0);
  json.setFloat("MAXFREQ", 1/30.0);
  json.setFloat("OPACITY_BACKGROUND",10);
  json.setFloat("LIMITPAN",0.99);
  json.setFloat("MINAMP",0.1);// -20 dB
  json.setFloat("MIN_BRIGHTNESS",100);
  json.setFloat("MIN_SATURATION",150);
  json.setFloat("MINAXIS_FACTOR",0.35);
  json.setFloat("MAXAXIS_FACTOR",0.95);
  json.setFloat("MIN_PHASE_DIFF",PI/4);
  json.setFloat("MAXRADIUS",20);
  json.setFloat("MIN_HUE",0);
  json.setFloat("MAX_HUE",255);
  json.setFloat("MINRADIUS_FACTOR",0.01);
  json.setFloat("CENTER_RADIUS",100);
  saveJSONObject(json, json_fn, "indent=2");
}

void loadJSON(){
  boolean json_exist=false;
  JSONObject json;
  try{
     json= loadJSONObject(json_fn);
     json_exist=true;
  }
  catch (Exception e) {
    createDefaultJSON();
    loadJSON();
    return;
  }
  
  if(!json.isNull("MINFREQ")){
      MINFREQ = json.getFloat("MINFREQ");
  }
  if(!json.isNull("MAXFREQ")){
      MAXFREQ = json.getFloat("MAXFREQ");
  }
  if(!json.isNull("OPACITY_BACKGROUND")){
      OPACITY_BACKGROUND = json.getFloat("TRANSPARENCY_BACKGROUND");
  }
  if(!json.isNull("LIMITPAN")){
      LIMITPAN = json.getFloat("LIMITPAN");
  }
  if(!json.isNull("MINAMP")){
      MINAMP = json.getFloat("MINAMP");
  }
  if(!json.isNull("MIN_BRIGHTNESS")){
      MIN_BRIGHTNESS = json.getFloat("MIN_BRIGHTNESS");
  }
  if(!json.isNull("MIN_SATURATION")){
      MIN_SATURATION = json.getFloat("MIN_SATURATION");
  }
  if(!json.isNull("MINAXIS_FACTOR")){
      MINAXIS_FACTOR = json.getFloat("MINAXIS_FACTOR");
  }
  if(!json.isNull("MAXAXIS_FACTOR")){
      MAXAXIS_FACTOR = json.getFloat("MAXAXIS_FACTOR");
  }
  if(!json.isNull("MIN_PHASE_DIFF")){
      MIN_PHASE_DIFF = json.getFloat("MIN_PHASE_DIFF");
  }
  if(!json.isNull("MAXRADIUS")){
      MAXRADIUS = json.getFloat("MAXRADIUS");
  }
  if(!json.isNull("MIN_HUE")){
      MIN_HUE = json.getFloat("MIN_HUE");
  }
  if(!json.isNull("MAX_HUE")){
      MAX_HUE = json.getFloat("MAX_HUE");
  }
  if(!json.isNull("MINRADIUS_FACTOR")){
      MINRADIUS_FACTOR = json.getFloat("MINRADIUS_FACTOR");
  }
  if(!json.isNull("CENTER_RADIUS")){
      CENTER_RADIUS = json.getFloat("CENTER_RADIUS");
  }


}

void setParameters(){
  if(IMPORT_JSON){loadJSON();}
  
  
  MINAXIS = MINAXIS_FACTOR*width/2;
  MAXAXIS = MAXAXIS_FACTOR*width/2;
  MINRADIUS= MINRADIUS_FACTOR*width;
  MAXDIST=width/2;
  if(MAX_HUE<MIN_HUE){MAX_HUE+=255;}

  center=new PVector(width/2, height/2);
  
}


void setup(){
  size(720, 720);
  t=0;
  setParameters();
  String path=sketchPath()+"/data";
  File dir = new File(path);
  print(dir.isDirectory());
  String filenames[] = dir.list();
  int num_files=filenames.length;
  
  movers=new ArrayList<Agent>();
  SoundFile sample;
  for(int i=0; i<num_files; i++){
     if(!filenames[i].endsWith(".wav")){
       println("Can't load ", filenames[i], "because it is not a wav file");
       continue;  
     }
     sample= new SoundFile(this, path+"/"+filenames[i]);     
     movers.add(new Agent(sample));
  }
  background(0);
  
}

void draw(){
  rectMode(CORNER);
  fill(0,OPACITY_BACKGROUND);
  rect(0,0,width, height);
  t+=1/frameRate;
  
  colorMode(HSB);
  fill(255);
  ellipse(center.x, center.y, CENTER_RADIUS, CENTER_RADIUS);    

  for(Agent mover: movers){
    mover.update(t);
    mover.draw(); 
    
   
  }
}
