class Tank {
  // Initial vars
  float speed;
  float angle;
  float angleVariation;
  float size;
  float x, y; 
  float hue;
  float alpha = 255;
  boolean shoot;
  boolean dead;
  int tankIndex;
  

  Tank(float size, int tankIndex) {
    this.size = size;
    this.tankIndex = tankIndex;
    initializeTank();
  }

  void drawTank() {
    if (!dead) {
      //Tank color
      fill(hue, 255, 255);
      // Draw tank
      pushMatrix();                // buffer the coordinate system
      translate(x, y);             // move it to creep center
      rotate(angle);               // rotate it to creep angle
      rect(0, 0, size * 2, size);  // notice initial coordinates now become (0, 0)
      line(0, 0, size * 2, 0);     // and we don't need to use angles here either! ;)
      rotate(PI/2);
      fill(255);
      textSize(6 + size/3);
      text(tankIndex + 1, -size/3, size/2);
      popMatrix();                 // restore it
      //Set tank to start shooting after frame 300
      if (frameCount > 300) {
        shoot = true;
      }
      //Random shooting based on size of tank
      if (random(0, 3000) < size * multiplier && shoot) {
        bullets.add(new Bullet(x, y, speed, angle, hue, tankIndex));
      }
    } else {
      //If tank is dead, color it black and fade
      fill(0, alpha);
      if (alpha > 20) {
        alpha -= 5;
      }
      // Draw tank
      pushMatrix();                // buffer the coordinate system
      translate(x, y);             // move it to creep center
      rotate(angle);               // rotate it to creep angle
      rect(0, 0, size * 2, size);  // notice initial coordinates now become (0, 0)
      line(0, 0, size * 2, 0);     // and we don't need to use angles here either! ;)
      rotate(PI/2);
      fill(255);
      textSize(4 + size/3);
      text(tankIndex + 1, -size/4, size/2);
      popMatrix();                 // restore it
    }
  }

  void initializeTank() {
    speed = random(1, 3);
    angle = (2*PI) / random(1, 9);
    angleVariation = PI / 18;
    x = width / 2;
    y = height / 2;
    shoot = false;
    dead = false;
    hue = random(0, 255);
  }

  void move() {
    //If tank is not dead, tank will move
    if (!dead) {
      // Add a random angle increment
      angle += random(-angleVariation, angleVariation);
      // Update new xy coordinates based on speed and angle
      x += speed * cos(angle);
      y += speed * sin(angle);

      // Check boundaries
      if (x > width - arenaWidth|| x < 0 + arenaWidth || y > height - arenaHeight || y < 0 + arenaHeight) {
        angle += PI;  // rotate 180 degs
        if(x > width - arenaWidth) {
          x -= 10;
        }
        if(x < 0 + arenaWidth) {
          x += 10;
        }
        if(y > width - arenaHeight) {
          y -= 10;
        }
        if(y < 0 + arenaHeight) {
          y += 10;
        }
      }
    }
  }
}