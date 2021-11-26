ip address show
read -p "what is interface name?" interface
read -p "whats the ssid?" ssid_name
read -p "whats the password?" ssid_pass

ip link set dev ${interface} up
iw dev ${interface} connect -w ${ssid_name} key 0:${ssid_pass}

