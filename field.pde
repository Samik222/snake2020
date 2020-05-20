class Field {
  // State (vars)
  final int COLOR = 0;

  int width;
  int height;

  Apple apple;

  // Behavior (methods)
  Field(int width, int height) {
    this.width = width;
    this.height = height;
  }

  boolean areCoordsInside(int x, int y) {
    return x >= 0 && x < width &&
      y >= 0 && y < height;
  }

  void draw() {
    noStroke();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int pixelX = centerighShiftX + x * cellPixelSize;
        int pixelY = centeringShiftY + y * cellPixelSize;
        fill(COLOR);
        image(fielD, pixelX, pixelY, cellPixelSize, cellPixelSize);
      }
    }
  }
}
