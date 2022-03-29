
import ddf.minim.*;
import ddf.minim.analysis.*;

class RythmMaster {
  
  GameWorld world;
  
  Minim minim;
  AudioPlayer track;
  BeatDetect beat;
  
  int beatCount = 0;
  
  public RythmMaster(PApplet parent, GameWorld world) {
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(parent);
    this.world = world;
    track = minim.loadFile("demon_dance.mp3", 2048);
  }
  
  public void startTrack() {
    track.play();
    beat = new BeatDetect(track.bufferSize(), track.sampleRate());
  }
  
  public boolean beatDetected() {
    beat.detect(track.mix);
    if (beat.isHat()) {
      beatCount++;
      return true;
    }
    return false;
  }
  
  public void setRythm() {
    //if (beatIsOn() && beatCount % 10 == 0) world.setSpeed(lerp(, world.SPEED_MAX, ));
    if (beatDetected() && beatCount % 6 == 0) {
      world.road.spawnObstacles();
      world.setSpeed(world.SPEED_MAX);
    }
    
    world.setSpeed(world.currentSpeedInCellsPerSecond * 0.95);
  }
  
}
