/**
 *
 *  Based on code from the tinker.it crew at http://www.tinker.it/files/rfid/tinker_rfid_print.html
 *
 **/
import processing.net.*;

String HTTP_GET_REQUEST = "GET /";
String HTTP_POST_REQUEST = "POST /";
String HTTP_HTML_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";
String HTTP_CSS_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/css\r\n\r\n";
String HTTP_GIF_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: image/gif\r\n\r\n";

 String INDEX_CSS = "@import url(http://fonts.googleapis.com/css?family=Advent+Pro:100);\r\n" +
 "html {\n" +
 "  background:  url(trippycat.gif) no-repeat center center fixed;\r\n" +
 "  background-size: cover;\r\n" +
 "}\r\n" +
 "h1{\r\n" +
 "  font-family: 'Advent Pro', sans-serif;\r\n" +
 "  font-size: 3em;\r\n" +
 "  margin: .2em .5em;\r\n" +
 "  color: rgba(200,100,100, 0.5);\r\n" +
 "}\r\n" +
 "body {\r\n" +
 "    height: 100%;\r\n" +
 "}\r\n";


class HTTPHandler {

  spiroID spiro;
  String buff = "";
  int NEWLINE = 10;
  int id;
  long value;
  Server server;
  Client client;
  String input;

  public HTTPHandler(spiroID parent)
  {
    this.spiro = parent;
    server = new Server(parent, 8666);
  }

  public int getID()
  {
    return id;
  }
  
  public void handleHttpRequest()
{
    // Receive data from client
    client = server.available();
    
    if (client != null) {
        input = client.readString().trim();    
        if ( input.indexOf("GET /trippycat.gif") == 0 ) {
          client.write(HTTP_GIF_HEADER);
          client.write(loadBytes("trippycat.gif"));
          client.stop();    
        } else if ( input.indexOf("GET /index.css") == 0 ) {
          client.write(HTTP_CSS_HEADER);
          client.write(loadBytes("index.css"));
          client.stop();    
        } else if (input.indexOf(HTTP_GET_REQUEST) == 0) {
          client.write(HTTP_HTML_HEADER);
          client.write(loadBytes("index.html"));
          client.stop();
        } else if ( input.indexOf(HTTP_POST_REQUEST) == 0)
        {
          client.write(HTTP_HTML_HEADER);
          String data = input.substring(input.indexOf("urlencoded")+10).replace("\"",""); // HACK out data
          JSONObject json = JSONObject.parse(data);
          
          client.write("<html><head><title>Beep boop</title><body><h3>" + "NDEF: " + json.getString("ndef") + "TWID: " + json.getString("twitter_handle") + "</title></head></html>");

          // HACK: convert data to twitter request and spiro callback
          createSpiroID((int)random(100));
          
          client.stop();
        }
    }
}
  
  public void callback() // calls back to the parent with the new ID.
  {
    createSpiroID(id);
  }
}


