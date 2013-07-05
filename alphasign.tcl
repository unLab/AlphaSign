# Script name   : alphasign.tcl
# Script Version: 2013033001
# Script Author : DGNP TeknoJuce
#
# Script Desc.  : Fire's messages to an Alpha Sign (4160R)
#                 with !sign <MESSAGE HERE>

bind pub o !sign pub_sign

proc pub_sign {nick uhost hand chan arg} {
  putserv "NOTICE $nick :Displayed your message on sign #1!"
  exec -- ~/signage.pl $nick:$arg
}

putlog "** AlphaSign.tcl by TeknoJuce & DGNP : loaded"
