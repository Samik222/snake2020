import ddf.minim.*;

Minim minim;
AudioPlayer appleNyamSound;
AudioPlayer turnSound;

void loadSounds() {
  minim = new Minim(this);
  appleNyamSound = minim.loadFile("apple.mp3");
  turnSound = minim.loadFile("turn.mp3");
}
