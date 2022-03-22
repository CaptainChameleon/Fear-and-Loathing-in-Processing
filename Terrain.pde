
interface Terrain {
  
  public void display();
  public void moveForward(float speed);
  
}

/*

float yoff;
float xoff;
float noiseMin = -10;
float noiseMax = 50;

class PerlinTerrain implements Terrain {
  
  private float minNoise;
  private float maxNoise;
  
  private int rows;
  private int cols;
  
  float[][] noiseMap;
  PShape mesh;
  
   public PerlinTerrain(float terrainWidth, float terrainDepth, float noiseMin, float noiseMax, float density) {
     
   }
   
   public void moveForward(float speed) {
     // Move noise a row below
     for (int y = rows-1; y >= 2 ; y--) {
       for (int x = 0; x < cols; x++) {
         noiseMap[x][y] = noiseMap[x][y-1];
       }
     }
     // Generate first row
     yoff -= 0.1;
     xoff = 0;
     for (int x = 0; x < cols; x++) {
       noiseMap[x][1] = map(noise(xoff, yoff), 0, 1, noiseMin, noiseMax);
       /*
       if (x >= cols/2 - (roadWidth/2) && x <= cols/2 + (roadWidth/2)) {
         noiseMap[x][1] = 0;
       } else {
         noiseMap[x][1] = map(noise(xoff, yoff), 0, 1, noiseMin, noiseMax);
       }
       */
        /*
       xoff -= 0.1;
     }
   }
   
  
   
   public void display() {
     //if (count % 2 == 0) updateTerrain(-0.04);
     count++;
     moveForward(-0.04);
  
   }
   
   private void generateNoiseMap() {
     noiseMap = new float[cols][rows];
     yoff = 0;
     for (int y = 0; y < rows; y++) {
       xoff = 0;
       for (int x = 0; x < cols; x++) {
         if (y == 0) {
           terrain[x][y] = map(noise(xoff, yoff), 0, 1, 5, 190);
         } else if (x >= cols/2 - (roadWidth/2) && x <= cols/2 + (roadWidth/2)) {
           terrain[x][y] = 0;
         } else {
           terrain[x][y] = map(noise(xoff, yoff), 0, 1, noiseMin, noiseMax);
         }
         xoff += 0.1;
       }
       yoff += 0.1;
     }
     yoff = 0;
     xoff = 0;   
   }
   
   private void buildMeshFromNoiseMap() {
     mesh = createShape();
     for (int y = 0; y < rows-1; y++) {
       mesh.beginShape(TRIANGLE_STRIP);
       mesh.noStroke();
       for (int x = 0; x < cols; x++) {
         if (x >= cols/2 - (roadWidth/2) && x <= cols/2 + (roadWidth/2) || y == 0) {
           mesh.noStroke();
           mesh.fill(0);
         } else {
           if (noiseMap[x][y] <= 0.025 || noiseMap[x][y+1] <= 0.025) continue;
           mesh.fill(250, 195, 0);
         }
         mesh.vertex(x*scl, y*scl, terrain[x][y]);
         mesh.vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
         //rect(x*scl, y*scl, scl, scl);
       }
       mesh.endShape();
     }
   } 
   
}

*/
