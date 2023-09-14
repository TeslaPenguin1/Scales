color c1 = #000000;
color c2 = #FFFFFF;
int delta = 0;

void setup() {
  size(1000,1000);
  background(0);
  noStroke();
  noFill();
}

void draw() {
  boolean shift = false;
  int xshift = 0;
  //colorMode(HSB);
  delta++;
  int drawDelta = delta;
  for(int y=0;y<=1000;y+=20) {
    colorMode(HSB);
    color c3 = color(colorFixed(drawDelta),255,255);
    color c4 = color(colorFixed(drawDelta-100),255,255);
    for(int x=0;x<=1000;x+=60) {
      scale(x+xshift+5,y-15,c3,c4);
    }
    shift = !shift;
    if (shift) xshift = 30;
    else xshift = 0;
    drawDelta-=2;
  }
  delta+=5;
}

int colorFixed(int x) {
   byte colTest = (byte)(-128+x);
   return (int)colTest+128;
  }

void scale(int x, int y, color c1, color c2) {
  arcGradient(x,y,0,4,40,20,PI,PI*2,c1,c2);
  quadGradient(x,y,x,y+40,x+15,y+40,x+20,y,c1,c2,2);
  quadGradient(x,y,x,y+40,x-15,y+40,x-20,y,c1,c2,4);
  quadGradient(x,y+40,x,y+40,x,y+60,x+15,y+40,c1,c2,2);
  quadGradient(x,y+40,x,y+40,x,y+60,x-15,y+40,c1,c2,4);
}

void quadGradient(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, color c1, color c2, int dir) {
  //Creates a gradient from (x1,y1,x4,y4) to (x2,y2,x3,y3)
  //dir: 1=down,2=right,3=up,4=left
  noFill();
  //colorMode(RGB);
  if (dir == 1) {
    for (int i = y1; i <= y4; i++) {
      float inter = map(i, y1, y4, 0, 1);
      float j = map(i, y1, y4, y2, y3);
      float k = map(i,y1,y4,x1,x4);
      float l = map(i,y1,y4,x2,x3);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(k, i, l, j);
    }
  }
  else if (dir == 2) {
    for (int i = x1; i <= x4; i++) {
      float inter = map(i, x1, x4, 0, 1);
      float j = map(i, x1, x4, x2, x3);
      float k = map(i,x1,x4,y1,y4);
      float l = map(i,x1,x4,y2,y3);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, k, j, l);
    }
  }
  else if (dir == 3) {
    for (int i = y1; i >= y4; i--) {
      float inter = map(i, y1, y4, 0, 1);
      float j = map(i, y1, y4, y2, y3);
      float k = map(i,y1,y4,x1,x4);
      float l = map(i,y1,y4,x2,x3);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(k, i, l, j);
    }
  }
  else if (dir == 4) {
    for (int i = x1; i >= x4; i--) {
      float inter = map(i, x1, x4, 0, 1);
      float j = map(i, x1, x4, x2, x3);
      float k = map(i,x1,x4,y1,y4);
      float l = map(i,x1,x4,y2,y3);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, k, j, l);
    }
  }
}

void arcGradient(float x, float y, int w1, int h1, int w2, int h2, float p1, float p2, color c1, color c2) {
  //w2 and h2 must be greater than w1 and h1 respectively
  noFill();
  //colorMode(RGB);
  if ((w2-w1) >= (h2-h1)) {
    for (int i = w1; i <= w2; i++) {
     float inter = map(i, w1, w2, 0, 1);
     float j = map(i, w1, w2, h1, h2);
     color c = lerpColor(c1, c2, inter);
     stroke(c);
     arc(x,y,i,j,p1,p2);
    }
  }
  else if ((w2-w1) < (h2-h1)) {
    for (int i = h1; i <= h2; i++) {
     float inter = map(i,h1,h2,0,1);
     float j = map(i,h1,h2,w1,w2);
     color c = lerpColor(c1,c2,inter);
     stroke(c);
     arc(x,y,j,i,p1,p2);
    }
  }
}
