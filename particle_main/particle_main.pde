import queasycam.*;

QueasyCam cam;
ParticleSystem ps;
Ball ball;

void setup(){
  size(800, 800, P3D);
  cam = new QueasyCam(this);
  cam.speed = 3;              // default is 3
  cam.sensitivity = 0.5;      // default is 2
  cam.position = new PVector(427.66196, -77.84119, 150.82361);
  lights();
  directionalLight(51, 102, 126, -1, 2, 0);
  ps = new ParticleSystem(new Vector(-195, -180, 0), 5000);
  ball = new Ball(-150, -150, 0, 20);
}

void draw(){
  surface.setTitle("FPS: " + (int) frameRate + ". Total particles: " + ps.particles.size());
  noStroke();
  background(135,206,235);
  
  // setting up lights
  lights();
  directionalLight(51, 102, 126, -1, 2, 0);
  
  // setting up the floor
  pushMatrix();
  translate(0,10,0);
  fill(153,153,153);
  box(600,10,600); // the floor
  
  // setting up the water source
  rotateY(PI/2);
  translate(-250,-100,0);
  fill(85,85,85);
  box(10,200,10);
  translate(30,-90,0);
  box(50,10,10);
  popMatrix();
  
  // set up the ball
  ball.render();
  
  // start the particle system
  ps.addParticle();
  ps.run();
  
  // DEBUG ----------------------
  // println(ps.particles.size());
  println(cam.position.x);
  println(cam.position.y);
  println(cam.position.z);
  println(mouseX);
  println(mouseY);
  //println(cam.getForward().x);
  //println(cam.getForward().y);
  //println(cam.getForward().z);
}

void keyReleased() {
  if (key == 'C' || key == 'c') {
    cam.controllable = !cam.controllable;
  }
}
