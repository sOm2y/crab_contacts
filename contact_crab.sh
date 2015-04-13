#!/bin/bash
#Author: Sam Yin
#Company: Coachseek
#Description: this is a bash script for Denym tracking customer contacts


WGET_Path=wget
DoesWGETExist=`$WGET_Path --version || echo "false"`
if [ "$DoesWGETExist" != false ]; then
  echo "==============================================================="
  echo "Please enter URL you want to collect from, followed by [ENTER]:"
  echo "==============================================================="
  read URL
  echo "========================================="
  echo " Collecting information from given url..."
  echo "========================================="
  cd ~/Desktop
  html="contact.html"
  txt="contact.txt"

  if [ -f "$html" ]
  then
    echo "$html found."
    rm contact.html
  fi 
  if [ -f "$txt" ]
  then
    echo "$txt found."
    rm contact.txt
  fi
  wget $URL -O contact.html
  echo "========================================="
  echo " $html has been created"
  echo "========================================="
  lynx --dump contact.html > contact.txt
  echo "========================================="
  echo " $txt has been created"
  echo "========================================="

  echo "========================================="
  echo " Collecting Completed"
  echo "========================================="


else
  echo "========================================================"
  echo " Missing dependency: wget (http://gnu.org/software/wget)"
  echo " Installing..."
  echo "========================================================"
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
  exit
fi






