
Vertex[] vertices = new Vertex[20];


// The statements in the setup() function 
// run once when the program begins
void setup() {
  size(800, 200);
  translate(width / 2, height / 2);
  smooth();
  for (int i = 0; i < vertices.length; i++) {
    vertices[i] = new Vertex(i * 10,0); 
  }

}

// The statements in draw() are run until the 
// program is stopped. Each statement is run in 
// sequence and after the last line is read, the first 
// line is run again.
void draw() {
  //filter( BLUR,1 );
  background(200);
  for (Vertex v: vertices) {
    PVector wind = new PVector(2, 3);
    v.applyForce(wind);
    v.update();
    v.display();
  }
} 

void mousePressed() {
  //loop();
}
