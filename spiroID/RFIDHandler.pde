/**
 *
 *  Based on code from the tinker.it crew at http://www.tinker.it/files/rfid/tinker_rfid_print.html
 *
 **/
import processing.serial.*;

class RFIDHandler {

  spiroID spiro;
  String buff = "";
  int NEWLINE = 10;
  int id;
  long value;

  public RFIDHandler(spiroID parent)
  {
    this.spiro = parent;
  }

  public int getID()
  {
    return id;
  }
  
  public void callback() // calls back to the parent with the new ID.
  {
    createSpiroID(id);
  }

 public void serialProcess(Serial port)
  {
    buff = port.readStringUntil(NEWLINE);
    buff = buff.trim(); // remote trailing newlines
    this.value = Long.parseLong(buff);
    int newId = (new Long(value)).intValue(); // simple casting to int. (edit later?)
    if (id != newId) // only do it if the thing is back
    {
      System.out.println("New tag! RAW: " + buff + "Intval:" + id);
      id = newId;
      callback();
    }
  }
  
  public void reset()
  {
     buff = "";
     value = 0;
     id = 0; 
  }
}


