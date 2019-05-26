//Processing code for MUS 104 Final piece score.

//Declare Global Variables
PImage[] imgs = new PImage[19]; // Init array from images
PImage img; // current image
int curImg = 0, array_selector=580; //current image index, init red box position
float x, y; //Init x,y values of scrolling red bar 
float tick, tick1; //Float for moving the scrolling red bar across the screen
int secondValue, thirdValue=120;//Array from SUperCollider
float firstValue; //Audio clock from SuperCollider for accurate sync.
PFont f; //Font
String sc_address="127.0.0.1"; //String containing WIFI address for SuperCollider connectivity

//Import OSC libraries
import oscP5.*; 
import netP5.*;

OscP5 oscP5; // object for OSC send and receive
NetAddress myRemoteLocation; // object for service address

void setup()
{
  //Screensize/Stroke Parameters
  size(1275,825);
  smooth(8);
  strokeWeight(4);
  stroke(255, 0, 0);

  //Load images into an array. Resize images to fit screen size.
  for(int i = 0; i < imgs.length; i ++){
  imgs[i] = loadImage("img"+(i)+".png");
  imgs[i].resize(imgs[i].width/4, imgs[i].height/4);
   }
  
  //Init first image
  img = imgs[curImg]; 
 
 
  //Starting point of scrolling red bar.
  x = 36; y = height;
  
  //Init font
  f = createFont("Arial",46,true);
  
  //Start OSC and listen port...
  oscP5 = new OscP5(this,4858); 
  
  //Set remote location to localhost SuperColider port
  myRemoteLocation = new NetAddress(sc_address,4859);
}

void draw()
{ 
  //Draw image
  imageMode(CORNER); //Specify image placement at the corners
  background(0); //Background
  image(imgs[secondValue], 0, 0); //Draw image
  
  //Draw array at top of the screen
  stroke(255, 0, 0);  

  textFont(f,16);  
  stroke(0);
  fill(0); 
  textSize(250);
  text(thirdValue, 750, 675); 

}

void oscEvent(OscMessage theOscMessage) 
{  
  //Get values from SuperCollider
  
  // get the first value as an float, the rest as ints
  firstValue = theOscMessage.get(0).floatValue();
  secondValue = theOscMessage.get(1).intValue();
  thirdValue = theOscMessage.get(2).intValue();
    
  //Move scolling red bar 
  tick = (firstValue % 3600);
  tick1 = tick * 0.94;
  x = tick1;
  
  //Print array from SuperCollider: for debugging
  //println(firstValue+ "  " +secondValue+ "  " +thirdValue + "  " + fourthValue + "  " + fifthValue + "  " + sixthValue + "  " + seventhValue + "  " + eighthValue + "  " + ninthValue + "  " + tenthValue + "  " + eleventhValue + "  " + twelvthValue+ "  " + thirteenthValue + "  " +  fourteenthValue  + "  " + fiftheenthValue);
}