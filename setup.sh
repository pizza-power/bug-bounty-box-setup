#!/bin/bash
# for use with Ubuntu 21.10
# some security tools to get started
# use this to setup new bug bounty box
# use at your own risk
# will need some manual adjustments

if [ "$EUID" -ne 0 ]
    then echo "Run as root!"
    exit
fi

apt update && apt upgrade -y

add-apt-repository universe

mkdir $HOME/{downloads,tools,scripts,projects}

cd downloads 

echo "htop \
python3-impacket \
git \
python3-pip \
nmap \
vim \
net-tools \
remmina \
vlc \
wireshark \
libcap2-bin \
curl \
tree \
net-tools \
mlocate \
nfs-kernel-server \
nfs-common \
p7zip-full \
p7zip-rar \
software-properties-common \
openvpn \
wireguard \
wireguard-tools \
traceroute \
tmux \
gobuster \
default-jdk \
gnupg \
ca-certificates \
gnupg \
lsb-release \
docker \
docker-compose \
zsh \
apt-transport-https \
john \
hashcat \
wfuzz \
nikto \
masscan \
ruby-full \
ruby-railties \
hydra \
cewl \
whois \
tshark \
nbtscan \
default-jdk \
squid
" > packages.txt

cat packages.txt | xargs sudo apt-get install -y

# install metasploit
wget https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

# install go, manually update to latest version
wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
tar -xvf go1.17.2.linux-amd64.tar.gz
chown -R root:root ./go
mv go /usr/local

# evilwinrm
gem install evil-winrm

# amass
curl -s https://api.github.com/repos/OWASP/Amass/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip amass* 
chmod +x ./amass_linux_amd64/amass 
mv ./amass_linux_amd64/amass /usr/bin/


# nuclei
curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip nuclei* nuclei
chmod +x nuclei
mv nuclei /usr/bin/

# httpx
curl -s https://api.github.com/repos/projectdiscovery/httpx/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip httpx* httpx
chmod +x httpx
mv httpx /usr/bin/

# subfinder
curl -s https://api.github.com/repos/projectdiscovery/subfinder/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip subfinder* subfinder
chmod +x subfinder
mv subfinder /usr/bin/

# aquatone
curl -s https://api.github.com/repos/michenriksen/aquatone/releases/latest | grep "browser_download_url.*linux_amd64-*" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip aquatone* aquatone
chmod +x aquatone 
mv aquatone /usr/bin

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

# cme 
wget https://github.com/byt3bl33d3r/CrackMapExec/releases/download/v5.1.7dev/cme-ubuntu-latest.zip
unzip cme-ubuntu-latest.zip -d "$HOME/tools/*"
pip3 install cffi==1.14.5


# maybe not needed stuff for impacket
ln -s /usr/bin/python3 /usr/bin/python
cp /usr/share/doc/python3-impacket/examples/* /usr/bin

# install zshrc
wget http://put ip here to download zsh:9999/.zshrc 

mv .zshrc $HOME

echo "export GOPATH=$HOME/go" >> $HOME/.zshrc
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> $HOME/.zshrc

reboot

