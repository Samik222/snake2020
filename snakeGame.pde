/* TODO:
 Сделать кнопкиу в экране проигрыша.
 */
// State
final int MENU_STATE    = 0;
final int GAME_STATE    = 1;
final int PAUSED_STATE  = 2;
final int LOST_STATE    = 3;

final int TITLE_COLOUR = 0xFFFF4C05;
final int TITLE_SIZE = 800;
final int TITLE_MARGIN_TOP = 50;

// Score
final int SCORE_SIZE = 50;
final int SCORE_COLOUR = 0xFFB1D654;

int score = 0;

// Animation in menu
ArrayList<Dot> dots = new ArrayList<Dot>();
int n = 0, c=5, frms = 100;
float theta;

// BALL
final int BALL_SIZE = 30;
final int HALF_BALL_SIZE = BALL_SIZE / 2;

// Draw game objects
Field field;
Snake snake;
Apple apple;

// Button "PLAY" in menu
int rectX, rectY;      // позиция прямоугольной кнопки    
color rectColor;
color rectHighlight;
boolean rectOver = false;
int rectSize1 = 200;
int rectSize2 = 50;

int state = MENU_STATE;

boolean overButton = false;

void setup() {
  fullScreen();
  background(0);

  loadFonts();
  loadSounds();
  loadImages();
}

void draw() {
  background(0);

  switch (state) {
  case MENU_STATE:
    drawInMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case LOST_STATE:
    drawLost();
    break;
  }
}

void drawInMenu() {
  while (n<300) {
    float offSet = PI/300*n;
    c = 2;
    float a = n*137.5;
    float r = c * sqrt(n);
    float x = width/2 + cos(a)*r;
    float y = height/2 + sin(a)*r;
    PVector start = new PVector(x, y);
    c = 20;
    a = n*137.5;
    r = c * sqrt(n);
    x = width/2 + cos(a)*r;
    y = height/2 + sin(a)*r;
    PVector end = new PVector(x, y);
    dots.add(new Dot(start, end, offSet));
    n++;
  }
  for (Dot d : dots) {
    d.update();
    d.show();
  }


  theta += TWO_PI/frms;

  if (overButton == true) {
    image(vkBlack, 0, 700, 75, 75);
  } else {
    image(vkWhite, 0, 700, 75, 75);
  }
  rectColor = color(0);
  rectHighlight = color(51);
  rectX = width/2 - 100;
  rectY = height/2 - 20;
  ellipseMode(CENTER);

  noStroke();
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);

  update(mouseX, mouseY);

  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255, 0, 0);
  rect(rectX, rectY, rectSize1, rectSize2);

  noStroke();

  fill(0, 0, 255);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("Snake 2020", width / 2, height / 2 - 100);

  fill(255, 0, 0);  
  textSize(50);
  textAlign(CENTER, CENTER);
  text("PLAY", width / 2, height / 2);
}

// Class for animation
class Dot {

  PVector start, end, v;
  float sz = 20;
  float x, y, lerpValue, offSet;

  Dot(PVector _start, PVector _end, float _offSet) {
    start = _start;
    end = _end;
    offSet = _offSet;
  }

  void show() {
    noStroke();
    fill(255, 100, 0);
    ellipse(v.x, v.y, sz, sz);
  }

  void update() {
    sz = map(sin(theta+offSet), -1, 1, 10, 30);
    lerpValue = map(sin(theta+offSet), -1, 1, 0, 1);
    v = PVector.lerp(start, end, lerpValue);
  }
}

void update(int x, int y) {
  if ( overRect(width / 2 - 100, height / 2 - 30, 200, 50) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (overButton) { 
    link("https://vk.com/sam177aby");
  }
  if (rectOver) {
    initGame();
    state = GAME_STATE;
  }
}

void mouseMoved() { 
  checkButtons();
}

void mouseDragged() {
  checkButtons();
}

void checkButtons() {
  if (mouseX > 0 && mouseX < 50 && mouseY > 690 && mouseY < 900) {
    overButton = true;
  } else {
    overButton = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawGame() {
  snake.move();

  field.draw();
  apple.draw();
  snake.draw();
  snake.drawScore();

  delay(200);
}

void drawLost() {
  field.draw();
  apple.draw();
  snake.draw();

  fill(0, 0, 0, 200);
  rect(width / 2 - 350, height / 2 - 400, 1000, 1000);
  oopsSprite.draw(width / 2 - 100, height / 2 - 200, 200, 200);
  fill(SCORE_COLOUR); 
  textAlign(CENTER, CENTER); 
  textSize(SCORE_SIZE); 
  text("You score: " + score, width / 2, height / 2);
  text("Press 'Enter' to go menu", width / 2, height / 2 + 40);
}

void keyPressed() {
  switch (state) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case LOST_STATE:
    keyPressedLost();
    break;
  }
}

void initGame() {
  field =  new Field(20, 20);
  snake = new Snake(field, 0, 0, 1, 0);
  apple = new Apple();

  recalcDrawingSizes();
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    initGame();
    state = GAME_STATE;
  }
}

void keyPressedInGame() {
  switch (key) {
  case 'w':
  case 'W':
    snake.turnUp();
    break;
  case 's':
  case 'S':
    snake.turnDown();
    break;
  case 'a':
  case 'A':
    snake.turnLeft();
    break;
  case 'd':
  case 'D':
    snake.turnRight();
    break;
  }

  switch (keyCode) {
  case UP:
    snake.turnUp();
    break;
  case DOWN:
    snake.turnDown();
    break;
  case LEFT:
    snake.turnLeft();
    break;
  case RIGHT:
    snake.turnRight();
    break;
  }
}

void keyPressedLost() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}
