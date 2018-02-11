/*******************************************************************************
 * Workout 07: Trigonometry_creep     //  Date: January 29, 2018
 * ARTG 2260: Programming Basics      // Instructor: Jose
 * Written By: Richard Tu             // Email: tu.r@husky.neu.edu
 * Title: Tank Arena!
 * Description: This is a miniature simulation that will simulate a tank fight
 Tanks have a random size, speed, and color. They will start
 shooting after frameCount 300 (to give tanks time to spread out)
 Bullets travel at 10x the tank's velocity (so faster tank -
 faster bullet). If a bullet collides within a tank's hull,
 bullet and tank will disappear. A bullet is shot randomly - the
 larger the tank, the more bullets it will fire.
 ******************************************************************************/

int tankCount = 50;
float gameSpeed = 50;
float arenaEndSize = 150;
PFont font;

//Arraylist of Tanks
ArrayList<Tank> tanks = new ArrayList<Tank>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//ArrayList<Integer> removeBullets = new ArrayList<Integer>();
ArrayList<Integer> removeTanks = new ArrayList<Integer>();
float arenaWidth;
float arenaHeight;
float multiplier = 1;
boolean pause = false;
int sKeyFrameCount = 0;            //Framecount for both 's' and 'S'
int inputDelay = 15;               //Input delay - for clicks and key presses


void setup() {
  size(1500, 1500);
  rectMode(CENTER);
  colorMode(HSB);
  font = loadFont("Stencil-48.vlw");
  //Fill tanks with Tank(s)
  for (int i = 0; i < tankCount; i++) {
    tanks.add(new Tank(random(10, 50), i));
  }
}

void draw() {
  textFont(font);
  background(191);

  //Draw arena
  fill(220);
  rectMode(CENTER);
  rect(width/2, height/2, width - arenaWidth * 2, height - arenaHeight * 2);

  //draw tanks
  for (int i = 0; i < tanks.size(); i++) {
    Tank tank = tanks.get(i);
    tank.drawTank();
    tank.move();
  }

  //draw bullets
  for (int i = 0; i < bullets.size(); i++) {
    Bullet bullet = bullets.get(i);
    bullet.drawBullet();
    bullet.move();
    if (bullet.x > width || bullet.x < 0 || bullet.y > height || bullet.y < 0) {
      bullets.remove(i);
    }
  }

  //If bullet collision:
  for (int i = 0; i < bullets.size(); i++) {
    Bullet bullet = bullets.get(i);
    for (int j = 0; j < tanks.size(); j++) {
      if (bullet.tankIndex != j && !tanks.get(j).dead) {
        if (bullet.x < tanks.get(j).x + tanks.get(j).size * 2 && 
          bullet.x > tanks.get(j).x - tanks.get(j).size * 2 &&
          bullet.y < tanks.get(j).y + tanks.get(j).size &&
          bullet.y > tanks.get(j).y - tanks.get(j).size) {
          //removeBullets.add(i);
          //removeTanks.add(j);
          bullets.remove(i);
          removeTanks.add(j);
          break;
        }
      }
    }
  }

  //Remove tanks - mark them as dead
  for (int i = 0; i < removeTanks.size(); i++) {
    tanks.get(removeTanks.get(i)).dead = true;
    tankCount -= 1;
  }
  removeTanks.clear();

  //Every 100 frames, decrease arena size
  if (frameCount % 125 == 0 && frameCount > 200) {
    if (arenaHeight < height/2 - arenaEndSize) {
      arenaHeight += gameSpeed;
    } else {
      multiplier = 10;
    }
    if (arenaWidth < width/2 - arenaEndSize) {
      arenaWidth += gameSpeed;
    }
  }

  //If one tank left, draw winning condition
  if (tankCount == 1) {
    multiplier = 200;
    for (int i = 0; i < tanks.size(); i++) {
      if (!tanks.get(i).dead) {
        textSize(100);
        fill(tanks.get(i).hue, 255, 255);
        text("Tank #" + (i + 1) + " won!", width/2 - 300, height/2);
      }
    }
  }
  println(tankCount);
}

void keyPressed() {
  if (key == 'p') {
    pause = !pause;
    if (pause) {
      noLoop();
    } else 
    loop();
  }
  //Save the frame to a file
  if (key == 's') {
    if (frameCount > sKeyFrameCount + inputDelay) {
      saveFrame("Drawing" + frameCount + ".png");
    }
    sKeyFrameCount = frameCount;
  }
}