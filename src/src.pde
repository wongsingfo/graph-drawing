import java.util.*;
import java.io.*;
import java.nio.file.*;

Random rand = new Random();
Vertex[] vertices = new Vertex[144];

Vertex[] loadGraph(String name, int indexFrom) {
  Path dataPath = Paths.get("/Users/wck/Desktop/Force", "testcase", name);
  BufferedReader datafile = null;
  Scanner scanner = null;
  Vertex[] graph = null;
  try {
    datafile = new BufferedReader(new FileReader(dataPath.toString()));
    scanner = new Scanner(datafile);
    int n = scanner.nextInt();
    int m = scanner.nextInt();
    graph = new Vertex[n];
    for (int i = 0; i < n; i++) {
      graph[i] = new Vertex(rand.nextFloat() * width, rand.nextFloat() * height);
    }
    for (int _ = 0; _ < m; _++) {
      Vertex u = graph[scanner.nextInt() - indexFrom];
      Vertex v = graph[scanner.nextInt() - indexFrom];
      u.add(v);
      v.add(u);
    }
  } catch (IOException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
  } finally {
    if (scanner != null) scanner.close();
  }
  return graph;
}

// The statements in the setup() function 
// run once when the program begins
void setup() {
  size(800, 600);
  translate(width / 2, height / 2);
  smooth();
  for (int i = 0; i < vertices.length; i++) {
    vertices[i] = new Vertex(i * 50, i * 5); 
  }
  
  vertices = loadGraph("jagmesh1", 1);

  //List<Vertex> l = Arrays.asList(vertices);
  //Collections.shuffle(l);
  //Vertex[] randomVertices = (Vertex[]) l.toArray();
  //case_mesh(randomVertices);
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
        i.applyForce(j.repulse(i));
      }
    }
    for (Vertex j: i.neighbors) {
      i.applyForce(j.attract(i));
    }
    
    i.update();
  }
  
  for (Vertex i: vertices) {
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
