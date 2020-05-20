int cellPixelSize = 35;
int centerighShiftX;
int centeringShiftY;

// Fonts
PFont mainFont;

void recalcDrawingSizes() {
  centerighShiftX = (width - field.width * cellPixelSize) / 2;
  centeringShiftY = (height - field.height * cellPixelSize) / 2;
}

void loadFonts() {
  mainFont = createFont("4384.ttf", 32);
  textFont(mainFont);
}

// Textures TODO:
PImage appLe;
PImage snakE;
PImage snakeHeadUPtrue;
PImage snakeHeadDOWNtrue;
PImage snakeHeadLEFTtrue;
PImage snakeHeadRIGHTtrue;
PImage snakeHeadUPfalse;
PImage snakeHeadDOWNfalse;
PImage snakeHeadLEFTfalse;
PImage snakeHeadRIGHTfalse;
PImage snakeHeadUpApple;
PImage snakeHeadDOWNApple;
PImage snakeHeadLEFTApple;
PImage snakeHeadRIGHTApple;
PImage fielD;
PImage vkWhite;
PImage vkBlack;

// Animation
SpriteOops oopsSprite;

void loadImages() {
  // Textures
  appLe = loadImage("apple.png");
  snakE = loadImage("snake.png");
  snakeHeadUPtrue = loadImage("snakeHeadUP.png");
  snakeHeadDOWNtrue = loadImage("snakeHeadDOWN.png");
  snakeHeadLEFTtrue = loadImage("snakeHeadLEFT.png");
  snakeHeadRIGHTtrue = loadImage("snakeHeadRIGHT.png");
  snakeHeadUPfalse = loadImage("snakeHeadUPfalse.png");
  snakeHeadDOWNfalse = loadImage("snakeHeadDOWNfalse.png");
  snakeHeadLEFTfalse = loadImage("snakeHeadLEFTfalse.png");
  snakeHeadRIGHTfalse = loadImage("snakeHeadRIGHTfalse.png");
  fielD = loadImage("field.png");
  vkWhite = loadImage("vk.png");
  vkBlack = loadImage("vk-black.png");

  // Animation
  oopsSprite = new SpriteOops("oops/oops", 7, ".png");
}

class SpriteOops {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  SpriteOops(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  SpriteOops(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}
