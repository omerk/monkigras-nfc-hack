# monkigras-nfc-hack

## What?

Generate beautifully unique Spirographs from MOO NFC cards and get them posted to you on Twitter!

A quick beer and cheese filled hack from @omerk, @exo and @darach, Monki Gras 2016

Based on nfc-reader by @nadam and spiroID by Matt Medland, Chris Roberts and co. at TinkerSoc.

Shoutout to Kernel Brewery and Raw Cheese Power for the lucid cheese dreams and the encouragement to hack.


## How?

MOO NFC cards, used on the great Jukebox hack have unique URL's encoded in them. We extract that NDEF record
and pass it along to spiroID (which is a Processing hack) alongside your Twitter ID. We then use that unique ID
as the seed for the spirograph, generate a PNG with some funky colours and upload it to Twitter with a mention
to you. 

Grab some MOO Jukebox cards and find us to try it out!


## Usage

Grab Android Studio and Processing, get the NFC Reader app on your phone and make sure you point it to the right
IP address and port that spiroID is running on (Tweak line ~370 in `TagViewer.java`). You will also need to set up
a Twitter app and dump the access tokens in the relavant section in the Processing app.

Please note that zero effort has gone into making this user friendly since it is but a hack so Here Be Dragons!


## License

NFC Reader is Copyright (C) 2011 Adam Nybäck, released under Apache License Version 2.0

Everything else in this repo is released under The Beerware License (What else would we use, srsly).



## Contact

Ping @OmerK, @jonsimpson and @darachennis on Twitter.





