import java.util.List;

class Road {
  
  float roadWidth;
  float roadDepth;
  
  int lanes;
  float laneWidth;
  float cellSize;
  
  List<Obstacle> obstacles;
  final float OBSTACLE_SIZE; 
  
  public Road(float roadWidth, float roadDepth, int lanes, float cellSize) {
    this.roadWidth = roadWidth;
    this.roadDepth = roadDepth;
    this.lanes = lanes;
    this.cellSize = cellSize;
    laneWidth = roadWidth / lanes; 
    OBSTACLE_SIZE = 0.5*laneWidth;
    obstacles = new ArrayList();
  }
  
  void spawnObstacles() {
    int obstacleNum = (int)random(lanes);
    for (int i = 0; i < obstacleNum; i++) {
      //obstacles.add(new Obstacle(new PVector(-roadWidth/2 + laneWidth*(int)random(lanes) + OBSTACLE_SIZE/2 + 0.25*laneWidth, -roadDepth, 0)));
      obstacles.add(new Obstacle(new PVector(100.0, 750.0, 0.0)));
    }
  }
  
  void moveForward(float speedInCellsPerSecond) {
    if (floor(time.currentTime / (1000/speedInCellsPerSecond)) <= floor(time.previousTime / (1000/speedInCellsPerSecond))) return;
    int steps = constrain(ceil(speedInCellsPerSecond/MAX_FRAMERATE), 1, 2);
    List<Obstacle> outOFBouds = new ArrayList();
    for (Obstacle obstacle : obstacles) {
      obstacle.moveForward(steps * cellSize);
      if (obstacle.position.y >= roadDepth) outOFBouds.add(obstacle);
    }
    obstacles.removeAll(outOFBouds);
  }
  
  void display() {
    pushStyle();
      noStroke();
      fill(0);
      
      rectMode(CENTER);
      rect(0, 0, roadWidth, roadDepth);
    popStyle();
    
    pushMatrix();
      translate( 0, 0, 0);
      for (Obstacle obstacle : obstacles) {
        obstacle.display();
      }
    popMatrix();
  }
  
}
