

class Car implements Collisionable {
   
  private PShape model;
  private HitBox hitBox;
  
  private Road road;
  private PVector position;
  private float turnSpeed;
 
  
  public Car(Road road, float proportionToRoadLane, PVector position, float turnSpeed) {
    model = loadShape("newcar3.obj");
    this.road = road;
    //car.disableStyle();
    model.scale(road.laneWidth * proportionToRoadLane / model.getWidth());
    model.setStroke(true);
    model.setStroke(color(255, 255, 255));
    model.setStrokeWeight(1.2f);
    model.setFill(color(0, 0, 0));
    this.position = position;
    this.turnSpeed = abs(turnSpeed);
    hitBox = new HitBox(model, position);
  }
  
  public HitBox getHitBox() {
    return hitBox;
  }
  
  public void move() {
    // Update position
    if (moveLeft && position.x - model.getWidth()/2 >= -road.roadWidth/2 + turnSpeed) {
      position.x -= turnSpeed;
    }
    if (moveRight && position.x + model.getWidth()/2 <= road.roadWidth/2 - turnSpeed) {
      position.x += turnSpeed;
    }
    
    // Update Hitbox position
    hitBox.position.x = position.x;    
  }
  
  public void display() {
    move();
    pushMatrix();
      translate(position.x, position.y, position.z + model.getHeight()/2);
      rotateX(-PI/2);
      shape(model);
    popMatrix();    
  } 

}
