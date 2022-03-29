
class Obstacle implements Collisionable {
  
  private PVector position;
  private HitBox hitBox;

  public Obstacle(PVector position) {
    this.position = position;
    hitBox = new HitBox(createShape(BOX, 50, 50, 50), position);
  }
  
  HitBox getHitBox() {
    return hitBox;
  }
  
  void moveForward(float distance) {
    position.y += distance;
    hitBox.position.y = position.y; 
  }
  
  void display() {
    pushStyle();
      pushMatrix();
        translate(position.x, position.y, position.z + hitBox.boundingBox.getHeight()/2);
        //rotateX(-PI/2);
        shape(hitBox.boundingBox);
      popMatrix(); 
    popStyle();
  }

}
