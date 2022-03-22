
class Road {
  
  float roadWidth;
  float roadDepth;
  
  int lanes;
  float laneWidth;
  
  Obstacle[] obstacles;
  
  public Road(float roadWidth, float roadDepth, int lanes) {
    this.roadWidth = roadWidth;
    this.roadDepth = roadDepth;
    this.lanes = lanes;
    laneWidth = roadWidth / lanes;  
  }
  
  void spawnObstacles(int num) {
  
  }
  
  void moveForward(int speed) {
  
  }
  
  void display() {
    noStroke();
    fill(0);
    
    rectMode(CENTER);
    rect(0, 0, roadWidth, roadDepth);
  }
  
}
