
Vertex[] vertices = new Vertex[20];


// The statements in the setup() function 
// run once when the program begins
void setup() {
  size(800, 200);
  translate(width / 2, height / 2);
  smooth();
  for (int i = 0; i < vertices.length; i++) {
    vertices[i] = new Vertex(i * 50, i * 5); 
  }

}

// The statements in draw() are run until the 
// program is stopped. Each statement is run in 
// sequence and after the last line is read, the first 
// line is run again.
void draw() {
  //filter( BLUR,1 );
  background(200);
  for (Vertex i: vertices) {
    for (Vertex j: vertices) {
      if (i != j) {
        PVector force = j.attract(i);
        i.applyForce(force);
      }
    }
    
    i.update();
    i.display();
  }
} 

boolean running = true;
void toggleLoop() {
  if (running) {
    noLoop();
  } else {
    loop();
  }
  running = ! running;
}

void mousePressed() {
  toggleLoop();
}
