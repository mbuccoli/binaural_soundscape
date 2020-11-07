int NUM_POINTS=100; 
float max_amp=0;
float min_amp=1;

float log10 (float x) {
  return (log(x) / log(10));
}

float MAXSTROKE=5;
float MINSTROKE=1;
float TOTALAMP=1;
class Agent{
  PVector position, axis, phase;
  float radius;
  SoundFile sample;
  color c;
  float hue;
  float freq;
  PVector[] orbit;
  float sw;
  Agent(SoundFile sample){
    this.sample=sample;
    this.freq=random(1.0/MAXTIME, 1.0/MINTIME);
    this.phase=new PVector(0,0);
    this.phase.x=random(-PI, PI);    
    this.phase.y=this.phase.x+random(MIN_PHASE_DIFF, PI-MIN_PHASE_DIFF);
    
    this.axis=new PVector(0,0);
    this.axis.x=random(MINAXIS, MAXAXIS);
    this.axis.y=random(MINAXIS, MAXAXIS);

    this.radius=0;
    this.c=0;
    this.sample.amp(0);
    this.sample.pan(0);
    this.sample.loop();
    this.sw=0;
    this.position=new PVector(0,0);
    this.hue=random(MIN_HUE  , MAX_HUE)%255;
    this.orbit=new PVector[NUM_POINTS];
    for(int i=0; i<NUM_POINTS; i++){
       float omega=map(i, 0, NUM_POINTS, 0, 2*PI);
        this.orbit[i]=new PVector(this.axis.x*cos(omega+this.phase.x),    
                                 this.axis.y*cos(omega+this.phase.y));    
        this.orbit[i].add(center);
    }
    //println(this.freq);
  }
  void update(float t){    
    this.position.x=this.axis.x*cos(2*PI*t*this.freq+this.phase.x);    
    this.position.y=this.axis.y*cos(2*PI*t*this.freq+this.phase.y);
    
    float dist= this.position.mag();

    float angle= this.position.heading();
    this.position.add(center);
    float pan=LIMITPAN*cos(angle);    
    //float amp=constrain(map(dist*dist, 0, MAXDIST*MAXDIST, 1, MINAMP), MINAMP, 1);
    //println(MAXAMP, MINAMP);
    float amp=constrain(pow(10,map(dist, MINAXIS, MAXDIST, MAXAMP, MINAMP)/20.0), pow(10,MINAMP/20.0), pow(10,MAXAMP/20.0));
    //float amp=constrain(map(log(dist), 0, log(0.001+MAXDIST), 0, MINAMP), MINAMP, 1);
    
    
    this.sample.pan(pan);
    this.sample.amp(MASTER_AMP*amp);
    max_amp=max(amp, max_amp);
    min_amp=min(amp, min_amp);
   
    /*println(dist,MAXDIST);*/
    colorMode(HSB, 255);
    float b=map(amp,pow(10,MINAMP/20.0), pow(10,MAXAMP/20.0), MIN_BRIGHTNESS, 255);
    float s=map(amp,pow(10,MINAMP/20.0), pow(10,MAXAMP/20.0), MIN_SATURATION, 255);
    this.sw=map(amp, pow(10,MINAMP/20.0), pow(10,MAXAMP/20.0), MINSTROKE, MAXSTROKE);
    this.radius=map(amp, pow(10,MINAMP/20.0), pow(10,MAXAMP/20.0), MINRADIUS, MAXRADIUS);
    
    this.c=color(this.hue, s, b);
    //println(amp, pan);
  }  
  void mute(boolean muted){
    if(muted){
      this.sample.amp(0);
      this.sample.pause();
    }
    else{
      this.sample.loop();
    }
  }
  
  
  void drawOrbit(){
    stroke(this.c);
    strokeWeight(this.sw);
    
    for(int i=1; i<NUM_POINTS+1; i++){
      line(this.orbit[i-1].x,this.orbit[i-1].y,this.orbit[i%NUM_POINTS].x,this.orbit[i%NUM_POINTS].y);      
    }  
  }
  void drawPlanet(){
    fill(c);
    noStroke();
    ellipse(this.position.x, this.position.y, this.radius, this.radius);    
  }
}
