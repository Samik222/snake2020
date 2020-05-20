class Apple {
  // State (vars)
  final int COLOR = 0xFFDB1414;
  int x, y;

  // Behavior (methods)
  Apple() {
    do {
      x = (int) random(field.width);
      y = (int) random(field.height);
    } while (snake.isColliding(x, y));
  }

  boolean isColliding(int x, int y) {
    return this.x == x && this.y == y;
  }

  void draw() {
    noStroke();
    fill(COLOR);

    int pixelX = centerighShiftX + x * cellPixelSize;
    int pixelY = centeringShiftY + y * cellPixelSize;
    image(appLe, pixelX, pixelY, cellPixelSize, cellPixelSize);
  }
}
