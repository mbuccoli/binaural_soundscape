 
class Agent{
  PVector position, axis, phase;
  float radius;
  SoundFile sample;
  color c;
  float hue;
  float freq;
  Agent(SoundFile sample){
    this.sample=sample;
    //println(MINFREQ, MAXFREQ);
    this.freq=random(MINFREQ, MAXFREQ);
    this.phase=new PVector(0,0);
    this.phase.x=random(-PI, PI);    
    this.phase.y=this.phase.x+random(MIN_PHASE_DIFF, 2*PI-MIN_PHASE_DIFF);

    this.axis=new PVector(0,0);
    this.axis.x=random(MINAXIS, MAXAXIS);
    this.axis.y=random(MINAXIS, MAXAXIS);

    this.radius=random(MINRADIUS, MAXRADIUS);
    this.c=0;
    this.sample.amp(0);
    this.sample.pan(0);
    this.sample.loop();
 
    this.position=new PVector(0,0);
    this.hue=random(MIN_HUE  , MAX_HUE)%255;
    //println(this.freq);
  }
  void update(float t){    
    this.position.x=this.axis.x*cos(2*PI*t*this.freq+this.phase.x);    
    this.position.y=this.axis.y*sin(2*PI*t*this.freq+this.phase.y);
    
    float dist= this.position.mag();
    float angle= this.position.heading();
    this.position.add(center);
    float pan=LIMITPAN*cos(angle);    
    float amp=constrain(map(dist*dist, 0, MAXDIST*MAXDIST, 1, MINAMP), MINAMP, 1);   
    this.sample.pan(pan);
    this.sample.amp(amp);
    
    colorMode(HSB, 255);
    float b=constrain(amp*255, MIN_BRIGHTNESS, 255);
    float s=constrain(amp*255, MIN_SATURATION, 255);
    
    this.c=color(this.hue, s, b);
    println(amp, pan);
  }  
  void draw(){
    fill(c);
    noStroke();
    ellipse(this.position.x, this.position.y, this.radius, this.radius);    
  }
}
