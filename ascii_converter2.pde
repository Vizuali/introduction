// the image to asciify
PImage img;
 
// sampling resolution: colors will be sampled every n pixels 
// to determine which character to display
int resolution = 9,
    fSize = 15;
 
// array to hold characters for pixel replacement
char[] ascii;
 
void settings(){
    size(480,625);
}
 
void setup() {
  img = loadImage("lincoln.jpg");
  background(255);
  fill(0);
  noStroke();
 
  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  String letters =  " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
  "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
  
  String reverse = "";
  
  for(int i = letters.length() - 1; i >= 0; i--){
    reverse = reverse + letters.charAt(i);
  }
  
  letters = reverse;
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }
 
  PFont mono = createFont("Courier", resolution + 2);
  mono = loadFont("UniversLTStd-Light-48.vlw");
  textFont(mono, fSize);
 
  //asciify();
}

void draw(){
  frameRate(10);
    textFont(mono, fSize);
  background(255);
  asciify();
}
 
void asciify() {
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  img.filter(GRAY);
  img.loadPixels();
 
  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < img.height; y += resolution) {
    for (int x = 0; x < img.width; x += resolution) {
      color pixel = img.pixels[y * img.width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}

void keyPressed() {
  switch (key) {
  case 'p':
    fSize -= 10;
    break;
  case 'P':
    fSize += 10;
    break;
  }
}
