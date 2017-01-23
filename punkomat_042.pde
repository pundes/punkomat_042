PImage img;

ArrayList<Picture> pictures;

int tileCountX = 4;
int tileCountY = 4;
int tileCount = tileCountX*tileCountY;

int tileWidth, tileHeight;

void setup() {
  size(1024, 576);
  
  frameRate(1);
  
  img = loadImage("image.jpg");
  image(img, 0, 0);
  
  tileWidth = width/tileCountY;
  tileHeight = height/tileCountX;
  
  pictures = new ArrayList<Picture>();
  
  for (int gridY = 0; gridY < tileCountY; gridY++){
      for (int gridX = 0; gridX < tileCountX; gridX++){
        pictures.add(new Picture(gridX*tileWidth, gridY*tileHeight));
      }
  }
}

void draw() {
  background(0);
  
  for(Picture p : pictures) {
    p.run();
  }
  
  saveFrame ("img/img####.png");
}




class Picture {
  PVector location;
  float randX, randY;
  int cropX;
  int cropY;
  int cropStartX;
  int cropStartY;
  int i = 0;
  int j = 0;
  float time = 0;
  //int state = 1;
  boolean selectMode;
  
  
  Picture(int x, int y) {
    location = new PVector(x, y);
  }
  
  void run() {
    cropStart();
    cropTiles();
  }
  
  void cropStart() {
    for(Picture p : pictures) {
     cropStartX = Math.round(p.location.x);
     cropStartY = Math.round(p.location.y);
     PImage crop = img.get(cropStartX, cropStartY, tileWidth, tileHeight);
     image(crop, p.location.x, p.location.y);
    }
  }

  
  void cropTiles() {
       
    for (int i = 0; i < pictures.size(); i++) {
            Picture part = pictures.get(i);
            
            randX = map(noise(time), 0, 1, part.location.x - 50, part.location.x  + 50); 
            randY = map(noise(time), 0, 1, part.location.y -50, part.location.y + 50); 
            
            randX = constrain(randX, 0, width-tileWidth);
            randY = constrain(randY, 0, height-tileHeight);
            
            cropX = int(randX);
            cropY = int(randY);
            
            println(part.location);
            println(cropX, cropY);
            
            PImage crop = img.get(cropX, cropY, tileWidth, tileHeight);
            image(crop, part.location.x, part.location.y);
            
            time = time + 0.001; 
     }

  }

}