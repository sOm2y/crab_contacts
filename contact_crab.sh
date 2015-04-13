#!/bin/bash
#Author: Sam Yin
#Company: Coachseek
#Description: this is a bash script for Denym tracking customer contacts

cd ~/Downloads

#install wget
curl -O http://ftp.gnu.org/gnu/wget/wget-1.15.tar.gz
tar -zxvf wget-1.15.tar.gz
cd wget-1.15/
./configure
./configure --with-ssl=openssl
make
sudo make install
rm -rf ~/Downloads/wget*

#install lynx 
cd /usr/local/src
curl -O http://lynx.isc.org/lynx2.8.7/lynx2.8.7.tar.gz
tar -xzvf lynx2.8.7.tar.gz
cd lynx2-8-7
./configure --mandir=/usr/share/man
make
sudo make install
rm -rf ~/Downloads/lynx*


cd ~/crab_contacts

#Remove old files
rm contact.html
rm contact.txt

URL="http://www.atpca.com.au/coach-search/?w1=-33.8674869&w2=151.20699020000006&dist=15"


wget $URL -O contact.html
lynx --dump contact.html > contact.txt


