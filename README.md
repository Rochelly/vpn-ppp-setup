# VPN ppp setup script
This script automates the setup of a VPN connection to a remote server using the ppp package and ssh. It also adds shortcuts for starting and stopping the VPN connection.

## Usage
Clone this repository or copy the vpn-setup.sh script to your local machine.
Open a terminal window and navigate to the directory containing the vpn-setup.sh script.
Run the script with the command: sudo bash vpn-setup.sh
Follow the prompts to configure the VPN connection.
To start the VPN connection, run the command vpn-start in a terminal window.
To stop the VPN connection, run the command vpn-stop in a terminal window.
Note: You may need to log out and log back in for the changes to the .bashrc file to take effect.

## Requirements
Debian-based Linux distribution (e.g. Ubuntu)
ppp package
ssh package
Configuration
The following variables in the vpn-setup.sh script must be configured for your specific use case:

* IP_GATEWAY: the IP address of the remote server
* LOCAL_POINT: the IP address of your local machine on the VPN network
* END_POINT: the IP address of the remote machine on the VPN network
* LOCAL_USER: your username on the local machine
* REMOTE_USER: your username on the remote server
* REMOTE_NET: the network address of the remote network
## Troubleshooting
If you have issues with the VPN connection, try the following:

* Verify that the configuration variables are set correctly.
* Verify that the ppp and ssh packages are installed.
* Check the system logs for any error messages related to the VPN connection.
* Try restarting the VPN connection by running vpn-stop followed by vpn-start.
## Disclaimer
Use this script at your own risk. The author is not responsible for any damages or losses caused by the use of this script.

#### NOTE:
The server must be prepared to accept the creation of the VPN, such as authentication by keys and permission to execute usr/sbin/pppd.
