
class Vertex {
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
    }

  }
};
