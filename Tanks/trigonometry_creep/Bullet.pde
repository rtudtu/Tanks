class Bullet {
  float x;
  float y;
  float speed;
  float angle;
  float hue;
  float tankIndex;

  Bullet(float x, float y, float speed, float angle, float hue, int tankIndex) {
    this.x = x;
    this.y = y;
    this.speed = speed * 10;
    this.angle = angle;
    this.hue = hue;
    this.tankIndex = tankIndex;
    initializeBullet();
  }


  void drawBullet() {
    //Draw bullet
    fill(hue, 255, 255);
    stroke(0);
    strokeWeight(1);
    ellipse(x, y, 10, 10);
  }

  void move() {
    //move bullet at the given speed and angle
    x += speed * cos(angle);
    y += speed * sin(angle);
  }

  void initializeBullet() {
    //Nothing to initialize (all fields depend on input into constructor)
  }
}