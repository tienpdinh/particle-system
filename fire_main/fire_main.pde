import queasycam.*;

QueasyCam cam;
ParticleSystem ps;
PImage tex;

void setup() {
  size(800, 800, P3D);
  cam = new QueasyCam(this);
  cam.speed = 0.2;              // default is 3
  cam.sensitivity = 0.5;      // default is 2
  ps = new ParticleSystem(new Vector(0, 10, 0), 2000, 2);
  tex = loadImage("Textures/fuzzyblob.png");
  cam.position = new PVector(40.046997, -3.732994 ,-0.04456464);
}

void draw() {
  surface.setTitle("FPS: " + (int) frameRate + ". Total particles: " + ps.particles.size());
  noStroke();
  //background(135,206,235);
  background(0);
  
  // setting up lights
  //lights();
  //directionalLight(51, 102, 126, -1, 2, 0);
  // setting up the floor
  pushMatrix();
  translate(0,1,0);
  fill(153,153,153);
  box(100,1,100); // the floor
  popMatrix();
  // start the particle system
  ps.addParticle();
  ps.run();
}

void keyPressed() {
  if (key == 'c')
    cam.controllable = false;
}
