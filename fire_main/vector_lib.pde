class Vector {
  public float x, y, z;
  
  public Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Vector projectToPlane(Vector normal) {
    Vector tmp = projectToLine(normal);
    return new Vector(x-tmp.x, y-tmp.y, z-tmp.z);
  }
  
  public Vector projectToLine(Vector directional) {
    float tmp = this.dot(directional);
    tmp /= directional.magnitudeSquared();
    return new Vector(directional.x*tmp, directional.y*tmp, directional.z*tmp);
  }
  
  public float magnitude() {
    return sqrt(x*x + y*y + z*z);
  }
  
  public float magnitudeSquared() {
    return x*x + y*y + z*z;
  }
  
  public Vector normalize() {
    float len = this.magnitude();
    return new Vector(x/len, y/len, z/len);
  }
  
  public float dot(Vector vec) {
    return x*vec.x + y*vec.y + z*vec.z;
  }
  
  public float angle(Vector vec) {
    return acos((this.dot(vec)/(this.magnitude()*vec.magnitude())));
  }
  
  public void add(Vector vec) {
    x += vec.x;
    y += vec.y;
    z += vec.z;
  }
  
  public Vector copy() {
    return new Vector(x, y, z);
  }
}
