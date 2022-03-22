
class GameWorld {
  
  private final float WORLD_TILT = PI/2.2;
  private final int SUN_SIZE = 400;
  private final float CAR_TO_RAIL_PROPORTION = 2.0/3.0;
  
  
  int cellSize;
  //float w = 8000;
  //float h = 4000;
  int worldWidth;
  int worldDepth;
  //int cols = worldWidth / cellSize;
  //int rows = worldDepth / cellSize;
  
  Car car;
  Road road;
  
  Terrain leftTerrain;
  Terrain rightTerrain;
  Terrain mountains;
  
  color skyColor = color(170, 80, 170);
  
  public GameWorld(int cellSize, int roadLanes) {
    this.cellSize = cellSize;
    worldWidth = Math.round(width * 1.3);
    worldDepth = Math.round(height * 5);
    road = new Road(SUN_SIZE, worldDepth, roadLanes);
    car =  new Car(road, CAR_TO_RAIL_PROPORTION, new PVector(0, worldDepth/4, 0), 3);
  }
  
  
  
  void update() {
    // Check collisions
    
    // Move Forward
    
    // Spawn Obstacles
  }
  
  void display() { 
    update();

    //translate(width/2, height/2+50, -worldDepth/4.5);
    translate(width/2, height/2, -worldDepth/5);
    
    displaySky();
    //pointLight(225, 70, 225, 0, -1500, -3000);
    
    rotateX(WORLD_TILT);
    
    // Terrain
    
    // Road
    road.display();
        
    // Car
    car.display();
  }
  
  private void displaySky() {
    //Sky
    background(skyColor);
    
    // Sun
    pushMatrix();
      //translate(0, -400, -3000);
      translate(0, -SUN_SIZE, -worldDepth - 2.5*SUN_SIZE);
      noStroke();
      fill(250, 160, 0);
      sphere(SUN_SIZE);
    popMatrix();
    
    // Clouds
    
  }
  
}
