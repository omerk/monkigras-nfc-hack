class Spiro
{
  float x,y,r1,r2;
  int n,r,g,b,a;
  
  Spiro(float x0, float y0, int seed)
  {
    randomSeed(seed);
    x = x0 / 2;
    y = y0 / 2;
    n = int(random(500,2000)); //The number of line for the spiral
    r1 = random(x * 0.2, x * 0.4);
    r2 = random(-x * 0.2, x * 0.2);

    //Colour Information
    r=int(random(10,225)); // Red
    g=int(random(10,225)); // Green
    b=int(random(10,225)); // Blue
    a=int(random(60,80));  // Alpha
  }

  void display() 
  {
    float x1;
    float y1;
    float x2 = 200;
    float y2 = 200;
    float ra = r1 + r2;
    float rb = r2;
    float rc = (r1 + r2) / r2 / TWO_PI;
    stroke(r,g,b,a);
    x2 = (ra - rb) + x;
    y2 = r1 + y;
    for (int i = 1;i < n; i++)
    {
      x1 = ra * cos(float(i) / TWO_PI) - rb * cos(rc * float(i)) + x;
      y1 = ra * sin(float(i) / TWO_PI) - rb * sin(rc * float(i)) + y;
      //Draw the line
      line(x1, y1, x2 , y2);
      x2 = x1;
      y2 = y1;
    }
  }
}
