#!/usr/bin/perl -w

###########################################
## PERL FILE FOR UPDATING THE ALPHA SIGN ##
##########################################
## http://www.alpha-american.com/alpha-manuals/M-Protocol.pdf

## Location of the sign's serial port.
$filename = "/dev/alpha";
open( LED, "> $filename" );
binmode( LED );

$message = join(' ', @ARGV);

# Tell the sign to do two short beeps before displaying the message.
print LED "\0\0\0\0\0\0\0\0\0\0\0" # Synchronize with the sign, multiple 0's are needed to negotiate the baud etc...
         ."\001" # Starting packet command, (\001 -> ^A)
         ."Z" # Type Code (Z->All Signs)
         ."00" # Sign Address (00->All Signs)
         ."\002" # Packet section divider (\002 -> ^B)
         ."E" # Command Code (E->Special Function)
         ."(" # Generate Speaker Tone
         ."2" # (1->Generate three, short beeps)
         ."01" # (10->Set speaker frequency, 00-FE)
         ."1" # (8->Length of tone, 1-F)
         ."1" # (2->Number of times tone is repeated, 0-F)
         ."\004"; # End of packet (\004 -> ^D)

# Construct packet to send to the sign, writing to textfile.
print LED "\0\0\0\0\0\0\0\0\0\0\0" # Synchronize with the sign, multiple 0's are needed to negotiate the baud etc...
         ."\001" # Starting packet command, (\001 -> ^A)
         ."Z" # Type Code (Z->All Signs)
         ."00" # Sign Address (00->All Signs)
         ."\002" # Packet section divider (\002 -> ^B)
         ."A" # Command Code (A->Write TEXT FILE)
         ."A" # File Label (A->Default Name)
         ."\033" # Escape Character (Needed)
         ."0" # Display Position (0->Fill Screen)
         ."g" # Mode Code (g->Roll Left)
         ."$message" # The actual message to save to the text file, to be displayed.
         ."\004"; # End of packet (\004 -> ^D)

## Close connection with the sign.
close(LED);
exit();
