color c1 = #000000;
color c2 = #FFFFFF;
int delta = 0;

void setup() {
  size(500,500);
  background(0);
  noStroke();
  noFill();
}

void draw() {
  boolean shift = false;
  int drawDelta = delta;
  for(int y=0;y<=500;y+=40) {
    color c3 = color(HSBtoRGB((colorFixed(drawDelta)/255.0),1,1));
    color c4 = color(HSBtoRGB((colorFixed(drawDelta-100)/255.0),1,1));
    scale(y-25,c3,c4,shift);
    if (y>=425) quadB2(y-25,c3,c4,shift);
    shift=!shift;
    drawDelta-=5;
  }
  delta+=5;
 }

int colorFixed(int x) {
   byte colTest = (byte)(-128+x);
   return (int)colTest+128;
    }

int shiftx(boolean shift) {
  if (shift) return 60;
  else return 0;
}

void scale(int y, color c1, color c2, boolean shift) {
  arcGradient(y,c1,c2,shift);
  quadA2(y,c1,c2,shift);
}

void quadB2(int y, color c1, color c2, boolean offset) {
  for (int i = 0; i <= 30; i++) {
      float inter = map(i, 0, 30, 0, 1);
      float j = map(i,0,30,y+80,y+120);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      for(int x=0;x<=500;x+=120) {
        line(x+i+shiftx(offset)+5, y+80, x+shiftx(offset)+5, j);
        line(x-i+shiftx(offset)+5, y+80, x+shiftx(offset)+5, j);
      }
   }
}

void quadA2(int y, color c1, color c2, boolean offset) {
  for (int i = 0; i <= 40; i++) {
      float inter = map(i, 0, 40, 0, 1);
      float j = map(i, 0, 40, 0, 30);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      for(int x=0;x<=500;x+=120) {
        line(x+i+shiftx(offset)+5, y, x+j+shiftx(offset)+5, y+80);
        line(x-i+shiftx(offset)+5, y, x-j+shiftx(offset)+5, y+80);
      }
   }
}

void arcGradient(float y, color c1, color c2, boolean offset) {
  //w2 and h2 must be greater than w1 and h1 respectively
    for (int i = 0; i <= 80; i++) {
     float inter = map(i, 0, 80, 0, 1);
     float j = map(i, 0, 80, 6, 40);
     color c = lerpColor(c1, c2, inter);
     stroke(c);
     for(int x=0;x<=500;x+=120) {
       arc(x+shiftx(offset)+5,y,i,j,PI,PI*2);
     }
  }
}

public static int HSBtoRGB(float hue, float saturation, float brightness) {
        int r = 0, g = 0, b = 0;
        if (saturation == 0) {
            r = g = b = (int) (brightness * 255.0f + 0.5f);
        } else {
            float h = (hue - (float)Math.floor(hue)) * 6.0f;
            float f = h - (float)Math.floor(h);
            float p = brightness * (1.0f - saturation);
            float q = brightness * (1.0f - saturation * f);
            float t = brightness * (1.0f - (saturation * (1.0f - f)));
            switch ((int) h) {
            case 0:
                r = (int) (brightness * 255.0f + 0.5f);
                g = (int) (t * 255.0f + 0.5f);
                b = (int) (p * 255.0f + 0.5f);
                break;
            case 1:
                r = (int) (q * 255.0f + 0.5f);
                g = (int) (brightness * 255.0f + 0.5f);
                b = (int) (p * 255.0f + 0.5f);
                break;
            case 2:
                r = (int) (p * 255.0f + 0.5f);
                g = (int) (brightness * 255.0f + 0.5f);
                b = (int) (t * 255.0f + 0.5f);
                break;
            case 3:
                r = (int) (p * 255.0f + 0.5f);
                g = (int) (q * 255.0f + 0.5f);
                b = (int) (brightness * 255.0f + 0.5f);
                break;
            case 4:
                r = (int) (t * 255.0f + 0.5f);
                g = (int) (p * 255.0f + 0.5f);
                b = (int) (brightness * 255.0f + 0.5f);
                break;
            case 5:
                r = (int) (brightness * 255.0f + 0.5f);
                g = (int) (p * 255.0f + 0.5f);
                b = (int) (q * 255.0f + 0.5f);
                break;
            }
        }
        return 0xff000000 | (r << 16) | (g << 8) | (b << 0);
    }
