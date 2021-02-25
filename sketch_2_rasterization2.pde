


void myLine (int x1, int y1, int x2, int y2)
{
  // insert your code here to draw a line from (x1, y1) to (x2, y2) 
  // using only calls to point().
  int dy = y2 - y1;
  int dx = x2 - x1;
  Boolean steep = abs(dy) > abs(dx);
  Boolean negative = (y1 - y2) > 0;
  
  if(dx == 0){
    for(int x=x1,y=y1; y<y2; y++){
      point(x,y);
    }
    return ;
  }
  
  if(steep) {
        int tmp = x1;
        x1 = y1;
        y1 = tmp;
        tmp = x2;
        x2 = y2;
        y2 = tmp;
    }
    if(x1 > x2) {
        int tmp = x1;
        x1 = x2;
        x2 = tmp;
        tmp = y1;
        y1 = y2;
        y2 = tmp;
    }
    
    int dE, dNE, dSE, x, y, d;
    
    dE = 2*dy;
    dNE = 2*(dy - dx);
    dSE = 2*dy + 2*dx;
    d = dE - dx;
    if(negative){
      d = dE + dx;
    }
    
    for(x=x1,y=y1; x<x2; x++){
      if(steep){
        point(y,x);
      }else{
        point(x,y);
      }
      if(!negative){ // if m > 0
        if(d <= 0){
          d+=dE;
        }else{
          y++;
          d += dNE;
        }
      }
      else{
        if(d>= 0){
          d+=dE;
        }
        else{
          y--;
          d+=dSE;
        }
      }
    }

  // your code should implement the Midpoint algorithm
}

void myTriangle (int x0, int y0, int x1, int y1, int x2, int y2)
{
  // insert your code here to draw a triangle with vertices (x0, y0), (x1, y1) and (x2, y2) 
  // using only calls to point().
  
  int[] xs = {x0, x1, x2}; //<>//
  xs = sort(xs);
  int[] ys = {y0, y1, y2};
  ys = sort(ys);
  
  // slope 0 - 1
  Boolean e0_v = false;
  float m0 = 0.0f;
  if((x1 - x0) == 0){
    e0_v = true;
  }
  else{
    m0 = (y1 - y0) / (x1 - x0);
  }
  // slope 1 - 2
  Boolean e1_v = false;
  float m1 = 0.0f;
  if((x2-x1) == 0){
    e1_v = true;
  }
  else{
    m1 = (y2 - y1) / (x2 - x1);
  }
  // slope 2 - 0
  Boolean e2_v = false;
  float m2 = 0.0f;
  if((x0-x2) == 0){
    e2_v = true;
  }
  else{
    m2 = (y0 - y2) / (x0 - x2);
  }
  
  for(int y=ys[0]; y<=ys[2]; ++y){
    ArrayList<Integer> intersections = new ArrayList(); //<>//
    for(int x=xs[0]; x<=xs[2]; x++){
      // check intersection with edge0-1
      if(e0_v == true){
        if(x == x0) {
          intersections.add(x);
          continue;
        }
      }
      else{
        int d1 = (int)(m0 * (x - x0) + y0 );
        if((y - d1) <= 1 && (y-d1) >=0){
          intersections.add(x);
          continue;
        }
      }
      
      if(e1_v == true){
          if(x == x1) {
            intersections.add(x);
            continue;
          }
      }
      else{
        int d2 = (int)(m1 * (x - x1) + y1 );
        if((y - d2) <= 1 && (y-d2)>=0){
          intersections.add(x);
          continue;
        }
      }
      
      if(e2_v == true){
          if(x == x2) {
            intersections.add(x);
            continue;
          }
      }
      else{
        int d3 = (int)(m2 * (x - x2) + y2 );
        if((y - d3) <= 1 && (y-d3)>=0){
          intersections.add(x);
          continue;
        }
      }
    }
      
      // if there is only 1 point of intersection
      if(intersections.size() == 1){ //<>//
        point(intersections.get(0), y);
      }
      else if(intersections.size() >= 2){
        int start = intersections.get(0);
        int end = intersections.get(intersections.size()-1);
        for(int i=start; i<end; i++){
          point(i, y);
        }
      }
    }
  
  
  
  // your code should implement the the algorithm presented in the video
}



// --------------------------------------------------------------------------------------------
//
//  Do not edit below this lne
//
// --------------------------------------------------------------------------------------------

boolean doMine = true;
int scene = 1;
color backgroundColor = color (150, 150, 150);

void setup () 
{
  size (500, 500);
  background (backgroundColor);
}

void draw ()
{
  fill (0,0,0);
    if (doMine) text ("my solution", 20, 475);
    else text ("reference", 20, 475);
    
  if (scene == 1) doLines();
  if (scene == 2) doHouse();
  
}

void doHouse()
{
  if (!doMine) {
    fill (255, 0, 0);
    stroke (255,0,0);
    triangle (200, 300, 300, 200, 200, 200);
    triangle (300, 300, 300, 200, 200, 300);
    fill (0, 0, 255);
    stroke (0,0,255);
    triangle (200,200, 300, 200, 250, 150);
    stroke (0,255,0);
    fill (0,255,0);
    triangle (250, 300, 275, 300, 250, 250);
    triangle (275, 300, 275, 250, 250, 250);
  }
  else {
    fill (128, 0, 0);
    stroke (128,0,0);
    myTriangle (200, 300, 300, 200, 200, 200);
    myTriangle (300, 300, 300, 200, 200, 300);
    fill (0, 0, 128);
    stroke (0,0,128);
    myTriangle (200,200, 300, 200, 250, 150);
    stroke (0,128,0);
    fill (0,128,0);
    myTriangle (250, 300, 275, 300, 250, 250);
    myTriangle (275, 300, 275, 250, 250, 250);
  }
}

void doLines()
{
  if  (!doMine) {
    stroke (255, 255, 255);
    line (50, 250, 450, 250);
    line (250, 50, 250, 450);
    line (50, 450, 450, 50);
    line (50, 50, 450, 450);
  }
  else {
    stroke (0, 0, 0);
    myLine (50, 250, 450, 250);
    myLine (250, 50, 250, 450);
    myLine (50, 450, 450, 50);
    myLine (50, 50, 450, 450);
  }
}

void keyPressed()
{
  if (key == '1') 
  {
    background (backgroundColor);
    scene = 1;
  }
  
  if (key == '2') 
  {
    background (backgroundColor);
    scene = 2;
  }
  
  if (key == 'm') 
  {
    background (backgroundColor);
    doMine = !doMine;
  }
  
  if (key == 'q') exit();
}
