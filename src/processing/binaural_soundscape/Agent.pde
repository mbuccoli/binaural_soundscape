 
class Agent{
  PVector position, axis, phase;
  float radius;
  SoundFile sample;
  float freq;
  Agent(SoundFile sample){
    this.sample=sample;
    println(MINFREQ, MAXFREQ);
    this.freq=random(MINFREQ, MAXFREQ);
    this.phase=new PVector(0,0);
    this.phase.x=random(-PI, PI);
    this.phase.y=random(-PI, PI);

    this.axis=new PVector(0,0);
    this.axis.x=random(MINAXIS, MAXAXIS);
    this.axis.y=random(MINAXIS, MAXAXIS);

    this.radius=random(MINRADIUS, MAXRADIUS);

    this.sample.amp(0);
    this.sample.pan(0);
    this.sample.loop();

    this.position=new PVector(0,0);
    println(this.freq);
  }
  void update(float t){    
    this.position.x=this.axis.x*cos(2*PI*t*this.freq+this.phase.x);    
    this.position.y=this.axis.y*sin(2*PI*t*this.freq+this.phase.y);
    
    float dist= this.position.mag();
    float angle= this.position.heading();
    this.position.add(center);
    float pan=LIMITPAN*cos(angle);    
    float amp=map(dist*dist, 0, MAXDIST*MAXDIST, MINAMP, 1);   
    this.sample.pan(pan);
    this.sample.amp(amp);
    println(amp, pan);
  }  
  void draw(color c){
    fill(c);
    noStroke();
    ellipse(this.position.x, this.position.y, this.radius, this.radius);    
  }
}
