class ParticleSystem {
  ArrayList<Particle> particles;
  Vector origin;
  int spawnRate;
  int time = millis();

  ParticleSystem(Vector position, int spawnRate) {
    this.spawnRate = spawnRate;
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    int tmp = millis();
    int dt = tmp - time;
    time = tmp;
    for (int i = 0; i < spawnRate * (dt / 1000.0); i++)
      particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

class Particle {
  Vector position;
  Vector velocity;
  Vector acceleration;
  float lifespan;

  Particle(Vector l) {
    acceleration = new Vector(0, 0.05, 0);
    velocity = new Vector(random(1, 2), 0, random(-0.5,0.5));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    if (position.y > 0) {
      velocity.y *= -0.5;
      position.y = 0;
    }
    // ball interaction
    if (distance(position, ball.position) < ball.r) {
      position = ball.getPointOnSurface(position);
      velocity.reflect(ball.getNormal(position));
    }
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  void display() {
    //stroke(0, lifespan);
    fill(79, 66, 181, lifespan);
    pushMatrix();
    rotateY(PI/2);
    translate(0,0,-position.z);
    square(position.x, position.y,2);
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    return lifespan < 0.0;
  }
}
