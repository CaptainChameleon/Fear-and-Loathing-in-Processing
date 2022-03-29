
FaceController controller;
TimeController time;

GameWorld world;
RythmMaster master;

final int MAX_FRAMERATE = 60;

enum GameState {
  MENU,
  TUTORIAL,
  PLAYING,
  ENDGAME
}

void setup() {
  size(1200, 600, P3D);
  //controller = new FaceController(this);
  time = new TimeController();
  world = new GameWorld(20, 3);
  master = new RythmMaster(this, world);
  startGame();
}


void draw() {
  time.update();
  master.setRythm();
  //controller.listen();
  world.display();
}

void startGame() {
  master.startTrack();
}
