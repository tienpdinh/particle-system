class Ball {
  public Vector position;
  float r;
  
  public Ball(float x, float y, float z, float r) {
    this.r = r;
    this.position = new Vector(x, y, z);
  }
  
  public void render() {
    update();
    pushMatrix();
    rotateY(PI/2);
    if (!cam.controllable)
      rotateY((new Vector(0,0,1).dot(new Vector(cam.getForward().x, cam.getForward().y, cam.getForward().z))));
    translate(position.x, position.y, position.z);
    fill(242,125,12);
    sphere(r);
    popMatrix();
  }
  
  public void update() {
    if (!cam.controllable) {
      position.x = mouseX-450;
      position.y = mouseY-width+450;
    }
  }
  
  public Vector getPointOnSurface(Vector pt) {
    Vector tmp = new Vector(pt.x - position.x, pt.y - position.y, pt.z - position.z);
    tmp.normalize();
    return new Vector(position.x + tmp.x * r, position.y + tmp.y * r, position.z + tmp.z * r);
  }
  
  public Vector getNormal(Vector pt) {
    Vector tmp = new Vector(pt.x - position.x, pt.y - position.y, pt.z - position.z);
    tmp.normalize();
    return tmp;
  }
}
