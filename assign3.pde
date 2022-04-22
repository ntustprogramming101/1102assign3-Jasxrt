final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

//gh state
final int GH_UP=0;
final int GH_DOWN=1;
final int GH_LEFT=2;
final int GH_RIGHT=3;
int ghState=GH_UP;

int animationRate=15;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1, soil2, soil3, soil4, soil5, life, stone1, stone2;
PImage  groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
//groundhog x,y
float groundhogX, groundhogY;
float groundhogSize=80;
float groundhogSpeed=80;
//soil offset
float soilOffsetY=0;
boolean soilDown=false;
// For debug function; DO NOT edit or remove this!
int playerHealth =2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  //ground start place
  groundhogX=320;
  groundhogY=80;
}

void draw() {
  /* ------ Debug Function ------
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */


  switch (gameState) {

  case GAME_START: // Start Screen
    image(title, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;

  case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);

    pushMatrix();
    if (soilOffsetY>-1600) {

      switch(ghState) {
      case GH_DOWN:
        if (animationRate<=15) {
          soilOffsetY = soilOffsetY-round(80/15);
          translate(0, soilOffsetY);
        } else {
          translate(0, soilOffsetY);
        }
        break;

      case GH_UP:
        translate(0, soilOffsetY);
        break;

      case GH_LEFT:
        translate(0, soilOffsetY);
        break;

      case GH_RIGHT:
        translate(0, soilOffsetY);
        break;
      }
    } else {
      soilOffsetY = -1600;
      switch(ghState) {
      case GH_DOWN:
        if (animationRate<15) {
          translate(0, soilOffsetY);
        } else {
          translate(0, soilOffsetY);
        }
        break;

      case GH_UP:
        translate(0, soilOffsetY);
        break;

      case GH_LEFT:
        translate(0, soilOffsetY);
        break;

      case GH_RIGHT:
        translate(0, soilOffsetY);
        break;
      }
    }


    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for (int x=0; x<9; x++) {
      for (int y=0; y<25; y++) {
        for (int j=1; j<9; j+=4) {
          for (int i=8; i<16; i+=4) {

            if (y<4) {
              image(soil0, x*80, y*80+160);
              image(stone1, x*80, x*80+160);
            } else if ( y<8&&y>3) {
              image(soil1, x*80, y*80+160);
              image(stone1, x*80, x*80+160);
            } else if ( y<12&&y>7) {
              image(soil2, x*80, y*80+160);
              image(stone1, j*80, i*80+160);
              image(stone1, (j+1)*80, i*80+160);
              image(stone1, j*80, (i+3)*80+160);
              image(stone1, (j+1)*80, (i +3)*80+160);
            } else if ( y<16&&y>11) {
              image(soil3, x*80, y*80+160);
              image(stone1, (j-1)*80, (i+1)*80+160);
              image(stone1, (j+2)*80, (i+1)*80+160);
              image(stone1, (j-1)*80, (i+2)*80+160);
              image(stone1, (j+2)*80, (i+2)*80+160);
            } else if ( y<20&&y>15) {
              image(soil4, x*80, y*80+160);
              if ( x%3==1&&y%3==1||
                x%3==0&&y%3==2||
                x%3==2&&y%3==0) {
                image(stone1, x*80, y*80 +160);
              } else if (x%3==2&&y%3==1||
                x%3==1&&y%3==2||
                x%3==0&&y%3==0) {
                image(stone1, x*80, y*80 +160);
                image(stone2, x*80, y*80 +160);
              }
            } else if (y<24&&y> 19) {
              image(soil5, x*80, y*80+160);
              if ( x%3==1&&y%3==1||
                x%3==0&&y%3==2||
                x%3==2&&y%3==0) {
                image(stone1, x*80, y*80 +160);
              } else if (x%3==2&&y%3==1||
                x%3==1&&y%3==2||
                x%3==0&&y%3==0) {
                image(stone1, x*80, y*80 +160);
                image(stone2, x*80, y*80 +160);
              }
            }
          }
        }
      }
    }

    // Player
    if (animationRate<15) {
      animationRate++;

      switch(ghState) {
      case GH_LEFT :
        image(groundhogLeft, groundhogX, groundhogY);
        groundhogX -= groundhogSpeed/15.0;
        break;
      case GH_RIGHT :
        image(groundhogRight, groundhogX, groundhogY);
        groundhogX += groundhogSpeed/15.0;
        break;
      case GH_DOWN :
        image(groundhogDown, groundhogX, groundhogY);
        groundhogY += groundhogSpeed/15.0;
        break;
      }

      if (animationRate == 15) {
        groundhogX = round(groundhogX);
        groundhogY = round(groundhogY);
      }
    } else {
      ghState=GH_UP;
      image(groundhogIdle, groundhogX, groundhogY);
    }

    if (groundhogX>560) {
      groundhogX-= 80/15.0;
    }
    if (groundhogX<0) {
      groundhogX+= 80/15.0;
    }
    if (groundhogY>2000) {
      groundhogY-= 80/15.0;
    }


    popMatrix();

    // Health UI
    for (int i=0; i<playerHealth; i++) {
      image(life, i*70+10, 10);
    }
    if (playerHealth<1) {
      gameState=GAME_OVER;
    }
    break;

  case GAME_OVER : // Gameover Screen
    image(gameover, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        playerHealth=2;
        groundhogX=320;
        groundhogY=80;
        soilOffsetY=0;
        ghState=GH_UP;
        mousePressed = false;
        // Remember to initialize the game here!
      }
    } else {

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}

void keyPressed() {
  // Add your moving input code here
  if (ghState==GH_UP) {
    switch(keyCode) {
    case DOWN :
      ghState=GH_DOWN;
      soilDown=true;
      animationRate=0;
      break;
    case LEFT :
      ghState=GH_LEFT;
      animationRate=0;
      break;
    case RIGHT :
      ghState=GH_RIGHT;
      animationRate=0;
      break;
    }
  }
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w' :
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's' :
    debugMode = true;
    cameraOffsetY -= 25;
    break;

  case 'a' :
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd' :
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}

void keyReleased() {
}
