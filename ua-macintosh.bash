#!/bin/bash
# Add Ukrainian (Macintosh) kbd layout in the Debian 9+.

if [ "$EUID" -ne 0 ]; then
  echo "You must have root privileges..."
  exit 1
fi

CODE='mac'
NAME='Ukrainian (Macintosh)'

# Change UA keyboard layout.
echo "1. Change UA keyboard layout: /usr/share/X11/xkb/symbols/ua"
sudo cat >>/usr/share/X11/xkb/symbols/ua <<EOL

partial alphanumeric_keys
xkb_symbols "$CODE" {
    include "ua(legacy)"
    name[Group1]= "$NAME";

    key <AC02> { [   Cyrillic_i,  Cyrillic_I  ] };
    key <AB05> { [  Ukrainian_i, Ukrainian_I  ] };

    key <LSGT> { [         less,     greater  ] };
    key <AE02> { [            2,    quotedbl  ] };
    key <AE03> { [            3,  numerosign  ] };
    key <AE04> { [            4,     percent  ] };
    key <AE05> { [            5,       colon  ] };
    key <AE06> { [            6,       comma  ] };
    key <AE07> { [            7,      period  ] };
    key <AE08> { [            8,   semicolon  ] };
    key <TLDE> { [ bracketright, bracketleft  ] };
    key <BKSL> { [ Ukrainian_ghe_with_upturn, Ukrainian_GHE_WITH_UPTURN ] };
};
EOL

# Add rules.
# List all valid kbd layouts.
# mac             ua: Ukrainian (Macintosh)
echo "2. Add valid kbd layout [$CODE ua: $NAME] into /usr/share/X11/xkb/rules/xorg.lst"
echo "* Insert it after last 'ua' -> '  homophonic ua: Ukrainian (homophonic)'"
sudo echo "  $CODE             ua: $NAME" >> /usr/share/X11/xkb/rules/xorg.lst

# Add into list.
XML="
        <variant>
          <configItem>
            <name>$CODE</name>
            <description>$NAME</description>
          </configItem>
        </variant>"

echo "3. Add rules into /usr/share/X11/xkb/rules/evdev.xml:"
echo -e "$XML"
echo -e "\n*Copy code and press ENTER...\n"
read
vim /usr/share/X11/xkb/rules/evdev.xml

# sudo rm /var/lib/xkb/*.xkm

echo "Reboot your system now."
echo "Done..."
exit 0
