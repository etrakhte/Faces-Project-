//FACES PROJECT: Andy Warhol erosions and dilations
//This code uses the open CV library to identify line patterns in face images and erode/dialate them.
//This erosion and dialation is to simulate the inconsistencies within prints along the same color and style as Andy Warhol!

import gab.opencv.*;
PImage src, dilated, eroded, both;
OpenCV opencv;
PGraphics pdf;

void setup() {
  //First we load up the image
  src = loadImage("face1.jpg"); 
  src.resize(src.width/2, 0);
  size(displayWidth, displayHeight);

  opencv = new OpenCV(this, src);

  // For dialation and erosion we will make a BW image to comply with the binary needs
  opencv.gray();
  opencv.threshold(100);
  opencv.invert();
  opencv.dilate();
   // save a snapshot to use in both operations
  src = opencv.getSnapshot();

  // erode and dilate patterns for print
  opencv.erode();
  opencv.dilate();
  opencv.dilate();
  opencv.erode();
  opencv.erode();
  opencv.dilate();
  opencv.dilate();
  eroded = opencv.getSnapshot();

  // reload image and erode it for
 opencv.loadImage(src);
 opencv.erode();
 
 
  // save dilated version for display
  dilated = opencv.getSnapshot();
  // now erode on top of dilated version to close holes
  opencv.loadImage(src);
   opencv.dilate();
    opencv.dilate();
     opencv.dilate();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  both = opencv.getSnapshot();
 
  noLoop();
}

void draw() {

  image(src, 0, 0);
  this.warholMaker();
  this.warholMaker2();
  image(dilated, 0, src.height); 
  this.warholMaker();
  this.warholMaker2();
  image(eroded, src.width, 0);
  this.warholMaker();
  this.warholMaker2();
  image(both, src.width, src.height);  
  this.warholMaker();
  this.warholMaker2();
  
  fill(50, 255, 255);
  text("print#1: ", 20, 20);
  text("print #2: ", src.width + 20, 20);
  text("print #3: ", 20, src.height+20);
  text("print #4: ", src.width+20, src.height+20);
 

}
// Changes the black background of the image to a fun color!
void warholMaker(){
  loadPixels(); 
  this.loadPixels();
   // New Randomly Generated Warhol color!
  color warholColor = color(colorRange(10,255),colorRange(10,255),colorRange(50,255));
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(this.pixels[loc]);
      float g = green(this.pixels[loc]);
      float b = blue(this.pixels[loc]);
      
     
    
      // Set the display pixel to the image pixel
      if(pixels[loc]== color(0,0,0) )
     pixels[loc] = warholColor ;          
    }
  }
  updatePixels();
}
int colorRange(int min, int max){
  
   int x = (int)(Math.random()*((max-min)+1))+min;
    return x;

}
//Changes the white part of the image to a fun color!
void warholMaker2(){
  loadPixels(); 
  this.loadPixels();
   // New Randomly Generated Warhol color!
  color warholColor = color(colorRange(10,255),colorRange(10,255),colorRange(50,255));
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(this.pixels[loc]);
      float g = green(this.pixels[loc]);
      float b = blue(this.pixels[loc]);
      
     
    
      // Set the display pixel to the image pixel
      if(pixels[loc]== color(255,255,255) )
     pixels[loc] = warholColor ;          
    }
  }
  updatePixels();
}
