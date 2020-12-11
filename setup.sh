#!/bin/bash
# for use with Ubuntu 20.04
# some security tools to get started
# use this to setup new bug bounty box
# use at your own risk

# check if running as root
if [ "$EUID" -ne 0 ]
	then echo "Run as root, please!"
	exit
fi

mkdir sectools
cd sectools

apt update -y && apt upgrade -y

# install some packages and tools that are used regularly
apt install \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common \
net-tools \
nmap \
john \
hashcat \
python3-pip \
wfuzz \
nikto \
gobuster \
masscan \
ruby-full \
ruby-railties \
wireguard \
nfs-common \
hydra \
cewl \
mlocate

# evil winrm
gem install evil-winrm

# powershell
snap install powershell --classic

# amass
curl -s https://api.github.com/repos/OWASP/Amass/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip amass* 
chmod +x ./amass_linux_amd64/amass 
mv ./amass_linux_amd64/amass /usr/bin/


# nuclei
curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf nuclei* nuclei
chmod +x nuclei
mv nuclei /usr/bin/

# httpx
curl -s https://api.github.com/repos/projectdiscovery/httpx/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf httpx* httpx
chmod +x httpx
mv httpx /usr/bin/

# subfinder
curl -s https://api.github.com/repos/projectdiscovery/subfinder/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf subfinder* subfinder
chmod +x subfinder
mv subfinder /usr/bin/

#aquatone setup
curl -s https://api.github.com/repos/michenriksen/aquatone/releases/latest | grep "browser_download_url.*linux_amd64-*" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip aquatone* aquatone
chmod +x aquatone && cp aquatone /usr/bin

# FFUF
curl -s https://api.github.com/repos/ffuf/ffuf/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf ffuf* ffuf
chmod +x ffuf
mv ffuf /usr/bin/

# getallurls (gau)
curl -s https://api.github.com/repos/lc/gau/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf gau* gau 
chmod +x gau 
mv gau /usr/bin

cd ..
echo "Don't forget to install metasploit, setoolkit, hexeditor, burp suite, wireshark, etc"
echo "all finished!"
