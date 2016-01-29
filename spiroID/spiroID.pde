

/**
 *  TinkerSoc spiroID generator.
 *
 *  Based upon code from http://laser3.ca.astro.it/applets/spiro5/index.html
 *
 *  Currently the only way to input the id is to manually change the seed
 **/
import processing.pdf.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.print.*;
import javax.imageio.ImageIO;

int n0;
int nmax=12;
int id = -2147483648; //Seed creation, when the RFID specs are known this will be the gathered number.
PFont font;
boolean spiroIDInitialised = false;
boolean spiroIDPrinted = false;
boolean spiroIDCreated = false;
String IMAGE_ROOT = "C:/tmp/";

Spiro[] spirals;
Printer printer;
HTTPHandler http;
TwitterPoster twitter;

void setup() 
{
  size(800, 600);
  // Initialise objects here to avoid null pointer exceptions

  http = new HTTPHandler(this);
  printer = new Printer();
  spirals =  new Spiro[nmax];
  twitter = new TwitterPoster();
}

/**
 *  Generates a spiroID, and gets it drawn.
 **/
String createSpiroID(int id)
{
  println("Creating spiro for id: " + id);
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
    println("Generation finished");
    String filename = new String(IMAGE_ROOT + "spiroID-"+id+".png");
    saveFrame(filename);
    println("Writing frame");
    return filename;
}


/**
 *  Draws the spiroID and saves it in a file "spiroID-##.png", where ## is
 *  the numerical id of the spiral.
 **/
void draw() 
{
    http.handleHttpRequest();
    
    //Draw the background and border.
    background(255);
    fill(0);
    rect(2,2,width-4,height-4);
    
    //Check that the spiral has been initialised
    if(spiroIDInitialised) {
      //Draw the spirals.
      for (int i=0; i < n0; i++)
      {
        spirals[i].display();
      }
      drawText();
      spiroIDCreated = true;
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
    //font = createFont("georgia.ttf", 52);
    //textFont(font, 52);
    //fill(255);
    //text("MonkiSpiroNfcThing", 10, 49);

    font = createFont("georgia.ttf", 28);
    textFont(font, 28);
    fill(255);
    text("Monki Gras 2016", width-220, height - 18);
}