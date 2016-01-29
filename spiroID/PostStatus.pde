import twitter4j.Status;
import twitter4j.StatusUpdate;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.UploadedMedia;
import twitter4j.conf.ConfigurationBuilder;

import java.io.File;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import java.nio.file.Path;
import java.nio.file.Paths;

class TwitterPoster {

  ConfigurationBuilder getConfig () {
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("kmm2hcPX2Lt5fNOIN34ntoBmI");
    cb.setOAuthConsumerSecret("tDqJysIcJCTnokjqa7PXrr0PEUEfJNK7Z5ND38zBahus340vut");
    cb.setOAuthAccessToken("4860002710-hL0gmfGCxETk4xZvyh7TwnPuk7WKRitFnwck8XN");
    cb.setOAuthAccessTokenSecret("RM3wovW8tq4iUZ0CoBjqI8eIAg2wRF3Vi8srsQ7KMLVJm");
    return cb;
  }
  
  void post(String text, String imageFilename) {
      try {
        String s = Paths.get(".").toAbsolutePath().normalize().toString();
        System.out.println("Current relative path is: " + s);
          Twitter twitter = new TwitterFactory(getConfig().build()).getInstance();
          File image = new File(imageFilename);
          System.out.println("Uploading...");
          StatusUpdate update = new StatusUpdate(text);
          update.setMedia(image);
          Status status = twitter.updateStatus(update);
          System.out.println("Successfully updated the status to [" + status.getText() + "][" + status.getId() + "].");
          System.exit(0);
      } catch (TwitterException te) {
          te.printStackTrace();
          System.out.println("Failed to update status: " + te.getMessage());
          System.exit(-1);
      }
  }
}