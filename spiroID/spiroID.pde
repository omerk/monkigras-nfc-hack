

/**
 *  TinkerSoc spiroID generator.
 *
 *  Based upon code from http://laser3.ca.astro.it/applets/spiro5/index.html
 *
 *  Currently the only way to input the id is to manually change the seed
 **/
import processing.serial.*;
import processing.pdf.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.print.*;
import javax.imageio.ImageIO;

int width=800;
int height=600;
int n0;
int nmax=12;
int id = -2147483648; //Seed creation, when the RFID specs are known this will be the gathered number.
PFont font;
boolean spiroIDInitialised = false;
boolean spiroIDPrinted = false;
boolean spiroIDCreated = false;
String IMAGE_ROOT = "./spirals/";

Spiro[] spirals;
Printer printer;
RFIDHandler rfid;
Serial port;

void setup() 
{
  size(width, height);
  // Initialise objects here to avoid null pointer exceptions
 

 
  rfid = new RFIDHandler(this);
  println(Serial.list());
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 57600);
  port.clear();
  port.buffer(32);
  port.bufferUntil('\n'); // should make serialEvent be called
  
  printer = new Printer();
  spirals =  new Spiro[nmax];
  noLoop();
}

/**
 *  Generates a spiroID, and gets it drawn.
 **/
void createSpiroID(int id)
{
    spiroIDInitialised = true;
    spiroIDCreated = false;
    spiroIDPrinted = false;
    this.id = id;
    // background(0); // why?
    randomSeed(id);
    n0 = 1 + int(random(2,nmax)); // Number of spirals
    for (int i=0; i < n0; i++)
    {
      spirals[i] = new Spiro(width, height, id + (29 * i) + i);
    }
    // Add "press P for a printout"?
    redraw();
}

/**
 *  Handles the key presses.
 * 
 *  Spacebar  -  Creates a new spiroID with an id plus one of the previous. For testing/faking a spiroID only.
 *  'p' key  -  Prints the spiroID. (If it has been created and not printed yet)
 *  'r' key  -  Enables retry of printing if first attempt fails.
 *  'g' key  -  Gets the ID from the RFID reader. (If the RFIDHandler didn't work automatically.)
 *  'B' key  -  Resets the spiroID to the blank, starting screen.
 */
void keyPressed()
{ 
  System.out.println(keyCode);
  if (keyCode == 32)                                            // Spacebar
  {
    createSpiroID(id + 1);
  } 
  else if(keyCode == 112 && spiroIDCreated && !spiroIDPrinted) { // 'p' key
    saveFile();
    printer.print("spiroID-"+id+".png");
    spiroIDPrinted = true;
  } 
  else if(keyCode == 113 && spiroIDCreated && spiroIDPrinted) {  // 'r' key
    spiroIDPrinted = false;
  }
//  else if(keyCode == 114) {                                      // 'g' key
//    createSpiroID(rfid.getID());
//  }
  else if(keyCode == 66) {                                      // 'B' key
    spiroIDInitialised = false;
    rfid.reset();
    redraw();
  } 
}

void saveFile()
{
    String filename = new String(IMAGE_ROOT + "spiroID-"+id+".png");
    saveFrame(filename); 
}

/**
 *  Draws the spiroID and saves it in a file "spiroID-##.png", where ## is
 *  the numerical id of the spiral.
 **/
void draw() 
{
    //Draw the background and border.
    background(255);
    fill(0);
    rect(2,2,width-4,height-4);
    String filename = new String(IMAGE_ROOT + "spiroID-"+id+".png");
    
    //Check that the spiral has been initialised
    if(spiroIDInitialised) {
      //Draw the spirals.
      for (int i=0; i < n0; i++)
      {
        spirals[i].display();
      }
      drawText();
      spiroIDCreated = true;
      println("Your spiroID is ready! (#" + id + ")");
    } 
    else {
      drawText();
      //Draw the error text.
      font = createFont("georgia.ttf", 24);
      textFont(font, 24);
      fill(255);
      text("Please Scan\nYour Card", 10, 88);
    }
}
  
void drawText()
  {
    //Draw the text.
    font = createFont("georgia.ttf", 52);
    textFont(font, 52);
    fill(255);
    text("spiroID", 10, 49);

    font = createFont("georgia.ttf", 28);
    textFont(font, 28);
    fill(255);
    text("tinkersoc.org", width-174, height - 18);
  }

void serialEvent(Serial serial)
{
  rfid.serialProcess(serial);
}
