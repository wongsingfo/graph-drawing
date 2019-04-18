
public class Vertex {
  private PVector location;
  private PVector accForce = new PVector();
  int id = rand.nextInt();
  
  List<Vertex> neighbors = new ArrayList<Vertex>();
  
  public void add(Vertex a) {
    neighbors.add(a);
  }
  
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
  
  private void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    if (neighbors.isEmpty()) {
      ellipse(location.x,location.y,24,24);
    } else {
      for (Vertex a : neighbors) {
        if (a.id > id) {
          line(location.x, location.y, a.location.x, a.location.y);
        }
      }
    }
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
