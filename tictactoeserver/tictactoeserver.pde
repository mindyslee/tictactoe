//Server- RUN FIRST (sends x's (2))

import processing.net.*;

color blue = #6FD7FF;
color pink = #FFC1F5;
boolean myTurn= true;


Server myServer; 

int[][] grid;

void setup() {
  size(300, 400);
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);
  myServer = new Server(this, 1234);
}

void draw() {
   if (myTurn)
  background(blue);
  else 
  background(pink);
  
  //draw lines
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);

  //draw the x's and o's
  int row = 0; 
  int col = 0;
  while (row < 3) {  //keep going until we go passed the last row
    drawXO(row, col);
    col++;            //go to next column
    if (col == 3) {   //we got to the end of the row, go to the next one
      col=0;
      row++;
    }
  }

  //drawMouseCoords();
  fill(0);
  text(mouseX + "," + mouseY, 150, 350);
    Client myClient = myServer.available();
  if (myClient != null) {
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    grid[r][c] = 1;
    myTurn = true;
  }
}

void drawXO(int row, int col) {
  pushMatrix();
  translate(row*100, col*100);
  if (grid[row][col] == 1) {
    noFill();
    ellipse(50, 50, 90, 90);
  } else if (grid[row][col] == 2) {
    line (10, 10, 90, 90);
    line (90, 10, 10, 90);
  }
  popMatrix();
}

void mouseReleased() {
  //assign the clicked-on box with the current player's mark
  int row = mouseX/100;
  int col = mouseY/100;
  if (myTurn && grid[row][col] == 0) {
    myServer.write(row + "," + col); 
    grid[row][col] =2;
     myTurn = false;
  }
}
