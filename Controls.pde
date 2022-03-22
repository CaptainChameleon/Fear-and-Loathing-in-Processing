
  
  boolean moveLeft;
  boolean moveRight;  



void keyPressed() {
  if (key == 'a' || key == 'A') {
    moveLeft = true;
  }
  if (key == 'd' || key == 'D') {
    moveRight = true;
  }
}
  
void keyReleased() {
  if (key == 'a' || key == 'A') {
    moveLeft = false;
  }
  if (key == 'd' || key == 'D') {
    moveRight = false;
  }
}


// FACE CONTROLS
class FaceController {
  
  private FaceDetector faceDetector;
  
  public FaceController(PApplet parent) {
    faceDetector = new FaceDetector(parent);
  }
  
  void listen() {
    Rect[] possibleFaces = faceDetector.scan();
    if (possibleFaces == null) return;
    float meanPosition = 0.0;
    for (Rect face : possibleFaces) {
      meanPosition += face.x + face.width/2;
    }
    meanPosition /= possibleFaces.length;
    if (meanPosition >= 2*width/3) {
      moveLeft = true;
      moveRight = false;
    } else if (meanPosition <= width/3) {
      moveLeft = false;
      moveRight = true;
    } else {
      moveLeft = false;
      moveRight = false;
    }
  }

}
