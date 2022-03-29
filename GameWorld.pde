
class GameWorld {
  
  private final float WORLD_TILT = PI/2.2;
  private final int SUN_SIZE = 400;
  private final float TERRAIN_SIZE;
  private final float CAR_TO_RAIL_PROPORTION = 2.0/3.0;
  private final int SPEED_MIN = 30;
  private final int SPEED_MAX = 120;
  
  
  int cellSize;
  int worldWidth;
  int worldDepth;
  
  Car car;
  Road road;
  
  Terrain leftTerrain, rightTerrain; //  Min Noise = -10   Max Noise = 50
  Terrain mountains; //  Min Noise = 5   Max Noise = 190
  
  color skyColor = color(170, 80, 170);
  
  float currentSpeedInCellsPerSecond = SPEED_MIN;
  
  public GameWorld(int cellSize, int roadLanes) {
    this.cellSize = cellSize;
    worldWidth = Math.round(width * 5);
    worldDepth = Math.round(height * 5);
    TERRAIN_SIZE = (worldWidth - SUN_SIZE) / 2;
    leftTerrain = new PerlinTerrain(TERRAIN_SIZE, worldDepth, cellSize*2.5, -10, 50);
    rightTerrain = new PerlinTerrain(TERRAIN_SIZE, worldDepth, cellSize*2.5, -10, 50);
    road = new Road(SUN_SIZE, worldDepth, roadLanes, cellSize);
    car =  new Car(road, CAR_TO_RAIL_PROPORTION, new PVector(0, worldDepth/4, 0), 10);
  }
  
  public void setSpeed(float speedInCellsPerSecond) {
    currentSpeedInCellsPerSecond = constrain(speedInCellsPerSecond, SPEED_MIN, SPEED_MAX);
  }  
  
  public void update() {    
    // Move Forward
    leftTerrain.moveForward(currentSpeedInCellsPerSecond);
    rightTerrain.moveForward(currentSpeedInCellsPerSecond);
    
    //road.moveForward(currentSpeedInCellsPerSecond);
    
    // Check collisions
    for (Obstacle obstacle : road.obstacles) {
     if(obstacle.position.y < 900 && obstacle.position.y > 600) println(car.getHitBox().boxWidth + " " + car.getHitBox().boxHeight + " " + car.getHitBox().boxDepth);
      if (areColliding(car.getHitBox(), obstacle.getHitBox())) {
        println("Colision!");
        obstacle.getHitBox().boundingBox.setFill(color(255, 0, 0));
      }
    }
  }
  
  public void display() { 
    update();

    translate(width/2, height/2, -worldDepth/5);
    
    displaySky();
    //pointLight(225, 70, 225, 0, -1500, -3000);
    
    rotateX(WORLD_TILT);
    
    // Terrain
    pushMatrix();
      translate(-(TERRAIN_SIZE + SUN_SIZE)/2, 0, 0);
      leftTerrain.display();
    popMatrix();
    pushMatrix();
      translate((TERRAIN_SIZE + SUN_SIZE) / 2, 0, 0);
      rightTerrain.display();
    popMatrix();
    
    // Road
    road.display();
        
    // Car
    car.display();
  }
  
  private void displaySky() {
    //Sky
    background(skyColor);
    
    // Sun
    pushStyle();
      pushMatrix();
        //translate(0, -400, -3000);
        translate(0, -SUN_SIZE, -(worldDepth + 2.5*SUN_SIZE));
        noStroke();
        fill(250, 160, 0);
        sphere(SUN_SIZE);
      popMatrix();
    popStyle();
    
    // Clouds
    
  }
  
}
