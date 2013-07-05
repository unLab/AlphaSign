AlphaSign
=========

Original Documentation: http://unlab.ca/w/AlphaSign


Plan

Fire a message from IRC to the physical space with our scavenged red LED Alpha signs.


Cost

Cost in 2001:

Alpha 4160R, Red with IR Keyboard $2,199.00

ALPHANET PLUS FOR WINDOWS SOFTWARE $199.00

Cost in 2013:

3 X Alpha 4160R Free! (Dumpster Dive)

Open Sourced Software Minds $20.00 ( In food ;) )


Attack

IRC Client -> CMD:!sign {msg} -> IRC Server (Freenode) -> ZNC -> EggDrop -> alphasign.tcl -> signage.pl -> Alpha Protocol -> RS232 -> Alpha Sign


Hackers

TeknoJuce & DGNP


Test Process from research pages

Creating a /dev/alpha Device on Linux

Creating the device is as simple as figuring out what serial port you've got the sign hooked up to. For instance, COM1:

# ln -s /dev/cua0 /dev/alpha
If you are brave, you can give the world read/write access to your sign. This may be important, especially if you are using a web server to update the sign.

# chmod a+rw /dev/alpha
Configuring the Communication Settings for Binary Access

Commands to the sign use control characters. (See the protocol.) These settings provide a 9600,E,7,1 connection to the sign for use with the RJ12 to RS232-DB9 adapter.


$ stty 0:705:1ad:0:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:73 < /dev/alpha

This is the same as $ stty 9600 -opost -ocrnl -onlcr cs7 parenb -parodd < /dev/alpha Testing the sign

alphatest.pl

#!/usr/bin/perl
# Get the attention of the sign
print "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";

# Tell the sign to print the message
$message = "It Worked!";
print "\001" . "Z" . "00" . "\002" . "AA" . "\x1B" . " b" . $message . "\004";

Make the code executable and run it, redirecting output to the sign's device:

$ chmod u+x alphatest.pl
$ ./alphatest.pl > /dev/alpha
The sign should now read "It Worked!"

