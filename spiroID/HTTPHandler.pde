/**
 *
 *  Based on code from the tinker.it crew at http://www.tinker.it/files/rfid/tinker_rfid_print.html
 *
 **/
import processing.net.*;

String HTTP_GET_REQUEST = "GET /";
String HTTP_POST_REQUEST = "POST /";
String HTTP_HTML_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";

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

  public void handleHttpRequest()
  {
    // Receive data from client
    client = server.available();
    
    if (client != null) {
        input = client.readString().trim();
        if ( input.indexOf(HTTP_POST_REQUEST) == 0) { 
        //input = "{\"twitter\": \"jonsimpson\",\"ndef\": \"\u0001moo.me/a/VpqaORqFM1RDJpSRRNMPoB\"}";
        String data = input.substring(input.indexOf("{")); // HACK out data
        System.out.println(data);
        
        JSONObject json = JSONObject.parse(data);
        System.out.println(json.toString());
        
        int id = Math.abs(json.getString("ndef").replace("\u0001moo.me/a/", "").hashCode());
        String twitterHandle = json.getString("twitter");
        
        if (!twitterHandle.startsWith("@")){
          twitterHandle = "@" + twitterHandle;
        }
        
        client.write(HTTP_HTML_HEADER);
        client.write("<html><head><title>Beep boop</title><body><h3>" + "NDEF: " + id + "TWID: " + json.getString("twitter") + "</title></head></html>");
        System.out.println(json.getString("ndef"));
        System.out.println(json.getString("twitter"));
        
        // HACK: convert data to twitter request and spiro callback
        String filename = createSpiroID(id);
        
        String statusText = "Hey " + twitterHandle + " here's your spiro";
        println("Twitter post: " + statusText);
        twitter.post(statusText, filename);
        
        client.stop();
        }
    }
}
  
  public void callback() // calls back to the parent with the new ID.
  {
    createSpiroID(id);
  }
}