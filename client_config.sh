#!/bin/bash

# Check if the script is being executed as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Install ppp package if not already installed
if ! dpkg -s ppp >/dev/null 2>&1; then
  apt-get update
  apt-get install -y ppp
fi

# VPN configuration
IP_GATEWAY="your_IP_SERVER"
LOCAL_POINT="private_local_IP"
END_POINT="private_remote_IP"
LOCAL_USER="you_user_name"
REMOTE_USER="your_remote_username"
REMOTE_NET="10.0.0.0/8" # replace with your  target remote net

# Check if configuration variables are defined correctly
if [[ -z $IP_GATEWAY || -z $LOCAL_POINT || -z $END_POINT || -z $LOCAL_USER || -z $REMOTE_USER || -z $REMOTE_NET ]]; then
  echo "Error: Some configuration variables are not defined correctly" 1>&2
  exit 1
fi

# Check if ssh package is installed
if ! dpkg -s ssh >/dev/null 2>&1; then
  apt-get update
  apt-get install -y ssh
fi

# Add VPN shortcuts for bash and zsh
cat <<EOF >> /home/$LOCAL_USER/.bashrc
alias vpn-start="sudo pppd updetach noauth silent nodeflate pty '/usr/bin/ssh $REMOTE_USER@$IP_GATEWAY -i /home/$LOCAL_USER/.ssh/id_rsa' ipparam vpn $LOCAL_POINT:$END_POINT; sudo ip route replace $REMOTE_NET via $END_POINT; echo -e '\033[0;32mVPN Created - Connected\e[0m';"
alias vpn-stop="sudo killall pppd; sudo ip route del $REMOTE_NET via $END_POINT; echo -e '\033[0;31mVPN Deleted - Disconnected\e[0m';"
EOF

cat <<EOF >> /home/$LOCAL_USER/.zshrc
alias vpn-start="sudo pppd updetach noauth silent nodeflate pty '/usr/bin/ssh $REMOTE_USER@$IP_GATEWAY -i /home/$LOCAL_USER/.ssh/id_rsa' ipparam vpn $LOCAL_POINT:$END_POINT; sudo ip route replace $REMOTE_NET via $END_POINT; echo -e '\033[0;32mVPN Created - Connected\e[0m';"
alias vpn-stop="sudo killall pppd; sudo ip route del $REMOTE_NET via $END_POINT; echo -e '\033[0;31mVPN Deleted - Disconnected\e[0m';"
EOF


# Reload bashrc and zshrc to apply changes
source /home/$LOCAL_USER/.bashrc
source /home/$LOCAL_USER/.zshrc

# Print instructions for using the VPN shortcuts
echo -e '\e\033[0;32m  Installation complete \e[m'
echo -e '\e\033[0;33m  Commands:\e[m'
echo -e '\e\033[0;33m  vpn-start: Start the VPN\e[m'
echo -e '\e\033[0;33m  vpn-stop: Stop the VPN\e[m'

# Print reminder to logout for changes to take effect
echo -e '\e\033[0;31m  Please logout to apply changes.\e[m'


