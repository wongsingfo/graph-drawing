void case_mesh(Vertex index[]) {
  int n = (int) sqrt((float) vertices.length);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      Vertex v = index[i * n + j];
      
      if (i + 1 < n) {
        Vertex u = index[(i+1) * n + j];
        v.add(u);
        u.add(v);
      }
      if (j + 1 < n) {
        Vertex u = index[i * n + (j+1)];
        v.add(u);
        u.add(v);
      }
    }
  }
}
