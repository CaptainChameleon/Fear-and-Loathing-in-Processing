
GameWorld world;
FaceController controller;

enum GameState {
  MENU,
  TUTORIAL,
  PLAYING,
  ENDGAME
}

void setup() {
  size(1200, 600, P3D);
  controller = new FaceController(this);
  startGame();
}


void draw() {
  controller.listen();
  //world.display();
}

void startGame() {
  // Cell Size, Road Lanes, 
  world = new GameWorld(20, 3);
}
