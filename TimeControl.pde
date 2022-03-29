
class TimeController {
  
  private float timeSinceLastStep; // Seconds
  float previousTime = 0.0;
  float currentTime = 0.0;
  
  public void update() {
    previousTime = currentTime;
    currentTime = millis();
    timeSinceLastStep = (currentTime - previousTime)/1000;
  }
  
  public float currentTimeInSeconds() {
    return currentTime/1000;
  }
  
  public float timeSinceLastIterationInSeconds() {
    return timeSinceLastStep;
  }

}
