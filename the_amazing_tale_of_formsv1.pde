//Characters
PVector p = new PVector(0, 0, 0);
PVector pc = new PVector(0, 0, 0);
Char ct = new Char(p, p, p, pc);
Char cc = new Char(40);
Char cr = new Char(40);

//Sea
int cols, rows;
int scl = 20; //size of the square
int w = 1200;//terrain size
int h = 900;
float flying= 0;

float [] [] terrain;


void setup() {
  size(600, 600, P3D);
  colorMode (HSB, 360, 100, 100);

  //for the sea
  cols = w / scl;
  rows = h / scl;
  terrain = new float [cols][rows];
  
}

void keyPressed()
{
  if ( key == 's') {
    saveFrame("line-######.png");
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  ct.tri_draw();
  cr.rect_draw();
  cc.cir_draw();

  //sea
  flying -=-0.02;
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff=flying;
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      terrain [x][y] = map(noise(xoff, yoff), 0, 1, -100, 150);
      xoff += 0.1;
    }
    yoff +=0.1;
  }
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      stroke(255);
      noFill();
      vertex(x*scl, y*scl, terrain [x][y] ); //points on each triangle
      vertex(x*scl, (y+1)*scl, terrain [x][y+1] );
      // rect (x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}