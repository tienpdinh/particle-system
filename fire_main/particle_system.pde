class ParticleSystem {
  ArrayList<Particle> particles;
  Vector origin;
  int spawnRate;
  int time = millis();
  int radius;

  ParticleSystem(Vector position, int spawnRate, int radius) {
    this.radius = radius;
    this.spawnRate = spawnRate;
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    int tmp = millis();
    int dt = tmp - time;
    time = tmp;
    for (int i = 0; i < spawnRate * (dt / 1000.0); i++)
      // uniformly random sample first
      particles.add(new Particle(randomOrigin()));
  }

  void run() {
    java.util.Collections.sort(particles);
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  Vector randomOrigin() {
    float r = radius  * sqrt(random(0,1));
    float theta = 2*PI*random(0,1);
    return new Vector(r*sin(theta),origin.y,r*cos(theta));
  }
}

class Particle implements Comparable<Particle> {
  Vector position;
  Vector velocity;
  Vector acceleration;
  float lifespan;

  Particle(Vector l) {
    acceleration = new Vector(0, 0, 0);
    velocity = new Vector(0, randomGaussian()*0.3 - 1.0, randomGaussian()*0.3);
    position = l;
    lifespan = 100.0;
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
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 3;
  }

  // Method to display
  void display() {
    //stroke(0, lifespan);
    //fill(79, 66, 181, lifespan);
    noFill();
    noTint();
    pushMatrix();
    rotateY(PI/2);
    translate(0,0,-position.z);
    
    // begin drawing texture
    // apply texture as well
    //tint(253,207,88,lifespan);
    beginShape();
    texture(tex);
    float r = lerp(253, 240, lifespan/100.0);
    float g = lerp(207, 127, lifespan/100.0);
    float b = lerp(88, 19, lifespan/100.0);
    tint(r,g,b,lifespan);
    vertex(position.x - 1, position.y - 1, 0, 0);
    vertex(position.x + 1, position.y - 1, tex.width, 0);
    vertex(position.x + 1, position.y + 1, tex.width, tex.height);
    vertex(position.x - 1, position.y + 1, 0, tex.height);
    endShape();
    //image(tex, position.x, position.y, 4, 4);
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    return lifespan < 0.0;
  }
  
  int compareTo(Particle p) {
    if (this.position.z - p.position.z > 0)
      return 1;
    else if (this.position.z - p.position.z < 0)
      return -1;
    return 0;
  }
}
