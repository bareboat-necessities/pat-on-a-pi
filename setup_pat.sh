#!/bin/bash

# Sets up your Raspberry Pi for use with Pat winlink client and Ardop. (Telnet also works.)
# I've not attempted to get this going with Winmor, as that protocol seems to be phased out or soon to be phased out on most gateways at the time of this writing.
# I've not attempted Pactor due to the cost. I've not attempted VARA. (It's not documented as an option for Pat, and I'm not even sure whether it works/has been ported to *nix.)
# This comes with no warranty, guarantee, or herbal tea. Use at your own risk, but myself or the community will try to help you if you get stuck.
# Backups are always a great idea. Hopefully, if you use your radio Pi portable, you've backed up its SD card (maybe one to take with you as spare, and one to leave at home for recovery).
# Alrigh, alright, here we go...

echo 'Downloading run helper scripts...'
mkdir -p ${HOME}/bin
wget -O ${HOME}/bin/run_pat.sh https://raw.githubusercontent.com/bareboat-necessities/pat-on-a-pi/main/run_pat.sh
chmod u+x ${HOME}/bin/run_pat.sh
wget -O ${HOME}/Desktop/runpat.desktop https://raw.githubusercontent.com/bareboat-necessities/pat-on-a-pi/main/runpat.desktop

mkdir -p ${HOME}/.wl2k
if [ -e "${HOME}/.wl2k/config.json" ]; then
  echo 'Detected existing Pat configuration. Hit Enter to overwrite, or Ctrl+C to finish setup with existing config.'
  echo '(Note that run_pat.sh may not work as intended if you use an existing config.)'
  read continue
fi
wget -O ${HOME}/.wl2k/config.json https://raw.githubusercontent.com/bareboat-necessities/pat-on-a-pi/main/pat_config.json

read -p 'Enter your callsign: ' callsign
sed -i "s/YourCallsignHere/${callsign}/" ${HOME}/.wl2k/config.json

read -sp 'Enter your Winlink password (will not echo): ' wlpass
sed -i "s/YourWinlinkPasswordHere/${wlpass}/" ${HOME}/.wl2k/config.json
unset wlpass
echo

read -p 'Enter your Grid Square: ' gridsquare
sed -i "s/YourGridSquareHere/${gridsquare}/" ${HOME}/.wl2k/config.json

echo 'Pat has been installed and configured!'
echo "You can run it with the helper script: ${HOME}/bin/run_pat.sh"
echo "or the Run Pat icon from the Start Menu."
