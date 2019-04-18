
public class Vertex {
  private PVector location;
  private PVector accForce = new PVector();
  
  public Vertex(float x, float y) {
    location = new PVector(x, y);
  }
  
  public void applyForce(PVector force) {
    accForce.add(force).limit(height);
  }
  
  public void update() {
    location.add(accForce.normalize().mult(step));
    checkEdges();
    accForce.mult(0);
  }
  
  public void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x,location.y,48,48);
  }
  
  public void checkEdges() {

    if (location.x > width) {
      location.x = width;
    } else if (location.x < 0) {
      location.x = 0;
    }

    if (location.y > height) {
      location.y = height;
    } else if (location.y < 0) {
      location.y = 0;
    }

  }
  
  public float distance(Vertex a) {
    return PVector.sub(location, a.location).mag();
  }
  
  public PVector attract(Vertex a) {
    float dis = distance(a);
    float strength = dis / K;
    
    PVector force = PVector.sub(location, a.location);
    force.normalize();
    force.mult(strength);
    return force;
  }
  
  public PVector repulse(Vertex a) {
    float dis = max(distance(a), 1.0);
    float strength = C * K * K / max(dis, 1.0);
    
    PVector force = PVector.sub(a.location, location);
    force.normalize();
    force.mult(strength);
    return force;
  }
};
