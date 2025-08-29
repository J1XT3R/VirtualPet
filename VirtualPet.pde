// import processing.serial.*;
// import cc.arduino.*;
// Arduino arduino;

float wingAngle = 0;

float dragonY;
float fireTimer = 0;

boolean breathingFire = false;
ArrayList<Particle> fireParticles;

// int lightLevels = 0;
// boolean canJump = true;
// int lastCheckedLevel = 0;

// int jumpHeight = 0;
// float gravity = 0.2f;

void setup() {
  size(600, 800);
  dragonY = height / 2;
  fireParticles = new ArrayList<Particle>();
  
  // arduino = new Arduino(this, Arduino.list()[2], 57600);
}

// void arduinoUpdate() {
  // lightLevels = (int)lerp(lightLevels, arduino.analogRead(5), 1);
  // System.out.println(lightLevels);
// }

void draw() {
  // arduinoUpdate();
  
  // The Sky
  for (int i = 0; i <= height; i++) {
    float interpolation = map(i, 0, height, 0, 1);
    color interporlatedColor = lerpColor(color(135, 206, 250), color(255, 218, 185), interpolation);
    stroke(interporlatedColor);
    line(0, i, width, i);
  }
  
  // Update dragon
  float dragonFrameHeight = height/2 + sin(frameCount * 0.02) * 30;
  
  // if ((lightLevels > (lastCheckedLevel + 5) || lightLevels < (lastCheckedLevel - 5)) && canJump) {
    // canJump = false;
    // jumpHeight += 50;
  // } else {
    // canJump = true;
  // }
  
  // jumpHeight = (int)(jumpHeight * gravity);
  // lastCheckedLevel = lightLevels;
  
  // dragonY = lerp(dragonFrameHeight, dragonFrameHeight + jumpHeight, 1);
  dragonY = lerp(dragonFrameHeight, dragonFrameHeight, 1);
  
  wingAngle = sin(frameCount * 0.15) * 0.8;
  
  // Fire
  if (frameCount % 120 == 0) {
    breathingFire = true;
    fireTimer = 0;
  }
  
  if (breathingFire) {
    fireTimer++;
    for (int i = 0; i < 3; i++) {
      fireParticles.add(new Particle(440, dragonY - 15));
    }
    
    if (fireTimer > 40) {
      breathingFire = false;
    }
  }
  
  // Draw Fire
  for (int i = fireParticles.size() - 1; i >= 0; i--) {
    Particle p = fireParticles.get(i);
    p.update();
    p.display();
    
    if (p.isDead()) {
      fireParticles.remove(i);
    }
  }
  
  // Draw dragon
  drawDragon(300, dragonY);
}

void drawDragon(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  // Wings 1
  drawWing(15, 0, wingAngle);
  
  // Dragon body
  fill(34, 139, 34);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, 120, 60);
  
  // Dragon neck
  fill(34, 139, 34);
  ellipse(40, -10, 80, 40);
  
  // Dragon head
  fill(50, 205, 50);
  ellipse(90, -15, 60, 50);
  
  // Dragon snout
  fill(34, 139, 34);
  ellipse(120, -10, 40, 25);
  
  // Eyes
  fill(255, 255, 0);
  ellipse(85, -25, 15, 15);
  ellipse(100, -22, 15, 15);
  
  // Eye pupils
  fill(0);
  ellipse(87, -25, 8, 8);
  ellipse(102, -22, 8, 8);
  
  // Nostrils
  fill(0);
  ellipse(125, -15, 3, 3);
  ellipse(125, -8, 3, 3);
  
  // Dragon tail
  fill(34, 139, 34);
  bezier(-60, 0, -100, -20, -120, 20, -140, -10);
  
  // Tail tip
  fill(255, 69, 0);
  pushMatrix();
  translate(-140, -10);
  rotate(0.3);
  triangle(0, 0, -15, -8, -15, 8);
  popMatrix();
  
  
  // Dragon belly scales
  fill(144, 238, 144);
  ellipse(0, 15, 80, 20);
  
  // Spikes on back
  fill(255, 69, 0);
  triangle(-40, -25, -35, -40, -30, -25);
  triangle(-20, -27, -15, -42, -10, -27);
  triangle(0, -28, 5, -43, 10, -28);
  triangle(20, -27, 25, -42, 30, -27);
  
  // Legs
  fill(34, 139, 34);
  ellipse(-30, 35, 15, 30); 
  ellipse(10, 35, 15, 30);
  ellipse(30, 35, 15, 30);
  
  // Wings 2
  drawWing(15, 0, -wingAngle);
  
  // Claws
  fill(139, 69, 19);
  for (int i = 0; i < 4; i++) {
    float legX = -30 + i * 30;
    
    // this is prob no the best way to do this
    if (i == 3) {
      continue;
    } else if (i == 1) {
      legX = -30 + (i+0.33) * 30;
    }
    
    triangle(legX - 3, 48, legX, 55, legX + 3, 48);
  }
  
  popMatrix();
}

void drawWing(float x, float y, float angle) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  
  fill(255, 140, 0, 180);
  stroke(139, 69, 19);
  strokeWeight(2);
  
  beginShape();
  vertex(0, 0);
  vertex(-40, -20);
  vertex(-60, 0);
  vertex(-40, 20);
  vertex(-20, 25);
  vertex(0, 15);
  endShape(CLOSE);
  
  stroke(139, 69, 19);
  strokeWeight(3);
  line(0, 0, -40, -20);
  line(0, 0, -60, 0);
  line(0, 0, -40, 20);
  line(0, 0, -20, 25);
  
  popMatrix();
}
