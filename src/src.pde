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
      float x = rand.nextFloat() + width / 2;
      float y = rand.nextFloat() + height / 2;
      graph[i] = new Vertex(x, y);
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
  smooth();
  vertices = loadGraph("jagmesh1", 1);

  //for (int i = 0; i < vertices.length; i++) {
  //  vertices[i] = new Vertex(i * 50, i * 5); 
  //}
  //List<Vertex> l = Arrays.asList(vertices);
  //Collections.shuffle(l);
  //Vertex[] randomVertices = (Vertex[]) l.toArray();
  //case_mesh(randomVertices);
}

float step = 8.0;
float step_scale = 0.9;
float energy0 = Float.POSITIVE_INFINITY;
int progress = 0;

void updateStep(float energy) {
  if (energy < energy0) {
    progress += 1;
    if (progress >= 5) {
      progress = 0;
      step /= step_scale;
    }
  } else {
    progress = 0;
    step *= step_scale;
  }
  
  if (step < 0.0000003) {
    toggleLoop();
  }
  
  energy0 = energy;
}

// The statements in draw() are run until the 
// program is stopped. Each statement is run in 
// sequence and after the last line is read, the first 
// line is run again.
void draw() {
  //filter( BLUR,1 );
  float energy = 0;
  
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
    
    energy += i.energy();
    i.update();
  }
  
  for (Vertex i: vertices) {
    i.display();
  }
  
  updateStep(energy);
  
  textSize(32);
  text(String.format("Energy: %f, step: %f", energy0, step), 10, 30);
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
