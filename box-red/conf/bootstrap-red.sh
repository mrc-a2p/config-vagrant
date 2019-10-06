# update / upgrade
echo "Updating apt-get..."
sudo apt-get update
sudo apt-get -y upgrade
sudo -s

apt-get -y install iptables isc-dhcp-server bind9
iptables -A FORWARD -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o enp0s -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -o enp0s -j MASQUERADE
iptables-save > /etc/firewall.conf
echo "#!/bin/sh" > /etc/network/if-up.d/iptables
echo "iptables-restore < /etc/firewall.conf" >> /etc/network/if-up.d/iptables
chmod -R 777 /etc/network/if-up.d/iptables
sed -i 's/#net.ipv4.ip_forward=1/ney.ipv4.ip_forward=1/g' /etc/sysctl.conf

#Red 1
echo "default-lease-time 600;" > /etc/dhcp/dhcp.conf
echo "max-lease-time 7200;" >> /etc/dhcp/dhcp.conf
echo "authoritative;" >> //etc/dhcp/dhcp.conf
echo "subnet 192.168.2.0 netmas 255.255.255.0 {" >> /etc/dhcp/dhcp.conf
echo "interface enp0s8;" >> /etc/dhcp/dhcp.conf
echo "range 192.168.2.2 192.168.2.254;" >> /etc/dhcp/dhcp.conf
echo "option routers 192.168.2.1;" >> /etc/dhcp/dhcp.conf
echo "option subnet-mask 255.255.255.0;" >> /etc/dhcp/dhcp.conf
echo "option broadcast-address 192.168.2.255;" >> /etc/dhcp/dhcp.conf
echo "option domain-name-servers 192.168.2.1;" >> /etc/dhcp/dhcp.conf
echo "}" >> /etc/dhcp/dhcp.conf 