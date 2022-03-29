interface Terrain {
  
  public void display();
  public void moveForward(float speed);
  
}


class PerlinTerrain implements Terrain {
  
  private final float noiseMin, noiseMax;
  
  private int rows, cols;
  private float[][] noiseMap;
  private final float terrainWidth, terrainDepth;
  private final float widthRoundError, depthRoundError;
  private final float cellSize;
  
  private PShape mesh;
  
  private float xoff, yoff;
  
   public PerlinTerrain(float terrainWidth, float terrainDepth, float cellSize, float noiseMin, float noiseMax) {
     this.cellSize = cellSize;
     this.noiseMin = noiseMin;
     this.noiseMax = noiseMax;
     this.terrainWidth = terrainWidth;
     this.terrainDepth = terrainDepth;
     rows = floor(terrainDepth / cellSize) + 1;
     cols = floor(terrainWidth / cellSize) + 1;
     depthRoundError = terrainDepth % cellSize;
     widthRoundError = terrainWidth % cellSize;
     generateNoiseMap();
     buildMeshFromNoiseMap();
   }
   
   public void moveForward(float speedInCellsPerSecond) {
     if (floor(time.currentTime / (1000/speedInCellsPerSecond)) <= floor(time.previousTime / (1000/speedInCellsPerSecond))) return;
     int steps = constrain(ceil(speedInCellsPerSecond/MAX_FRAMERATE), 1, 4);
     for (int i = 0; i < steps; i++) {
       // Move noise a row below
       for (int y = rows-1; y > 0 ; y--) {
         for (int x = 0; x < cols; x++) {
           noiseMap[x][y] = noiseMap[x][y-1];
         }
       }
       // Generate next first row
       yoff -= 0.1;
       xoff = 0;
       for (int x = 0; x < cols; x++) {
         noiseMap[x][0] = map(noise(xoff, yoff), 0, 1, noiseMin, noiseMax);
         xoff -= 0.1;
       }
     }
     buildMeshFromNoiseMap();
   }
   
  
   
   public void display() {
     pushMatrix();
       translate(-terrainWidth/2, -terrainDepth/2);
       shape(mesh);
     popMatrix();
   }
   
   private void generateNoiseMap() {
     noiseMap = new float[cols][rows];
     yoff = 0;
     for (int y = 0; y < rows; y++) {
       xoff = 0;
       for (int x = 0; x < cols; x++) {
         noiseMap[x][y] = map(noise(xoff, yoff), 0, 1, noiseMin, noiseMax);
         xoff += 0.1;
       }
       yoff += 0.1;
     }
     yoff = 0;
     xoff = 0;   
   }
   
   private void buildMeshFromNoiseMap() {
     mesh = createShape();
     mesh.beginShape(QUAD_STRIP);
     mesh.noFill();
     mesh.stroke(color(250, 195, 0));
     boolean reverse = false;
     for (int y = 0; y < rows-1; y++) {
       //mesh.noStroke();
       if (!reverse) {
         for (int x = 0; x < cols; x++) {
           //if (noiseMap[x][y] <= 0.025 || noiseMap[x][y+1] <= 0.025) continue;
           //mesh.fill(250, 195, 0);
           if (x == 0 || x == cols-1) {
             mesh.vertex(x*(cellSize + widthRoundError/cols), y*(cellSize + depthRoundError/rows), 0);
             mesh.vertex(x*(cellSize + widthRoundError/cols), (y+1)*(cellSize + depthRoundError/rows), 0);
           } else {
             mesh.vertex(x*(cellSize + widthRoundError/cols), y*(cellSize + depthRoundError/rows), noiseMap[x][y]);
             mesh.vertex(x*(cellSize + widthRoundError/cols), (y+1)*(cellSize + depthRoundError/rows), noiseMap[x][y+1]);
           }
           
           //rect(x*scl, y*scl, scl, scl);
         }
       } else {
         for (int x = cols-1; x >= 0; x--) {
           //if (noiseMap[x][y] <= 0.025 || noiseMap[x][y+1] <= 0.025) continue;
           //mesh.fill(250, 195, 0);
           if (x == 0 || x == cols-1) {
             mesh.vertex(x*(cellSize + widthRoundError/cols), y*(cellSize + depthRoundError/rows), 0);
             mesh.vertex(x*(cellSize + widthRoundError/cols), (y+1)*(cellSize + depthRoundError/rows), 0);
           } else {
             mesh.vertex(x*(cellSize + widthRoundError/cols), y*(cellSize + depthRoundError/rows), noiseMap[x][y]);
             mesh.vertex(x*(cellSize + widthRoundError/cols), (y+1)*(cellSize + depthRoundError/rows), noiseMap[x][y+1]);
           }
           //rect(x*scl, y*scl, scl, scl);
         }
       }
       reverse = !reverse;
     }
     mesh.endShape();
   } 
   
}
