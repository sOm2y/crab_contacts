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
  eval "$URL" -o contact.html 
  echo "========================================="
  echo " $html has been created"
  echo "========================================="
  # lynx --dump contact.html > contact.txt
  contact.html | grep -oe '\w*.\w*@\w*.\w*.\w\+' | sort -u >contact.txt
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


curl 'http://www.collegecoachesonline.com/member_listing.php' -H 'Pragma: no-cache' -H 'Origin: http://www.collegecoachesonline.com' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: http://www.collegecoachesonline.com/member_home.php' -H 'Cookie: loggedIn=yes; recordID=10762; recordName=IANPBISHOP; login_55d3b5912e5ba=73caf18d4d4e25278fce631cb09b0222; _ga=GA1.2.1210110192.1439936269' -H 'Connection: keep-alive' --data 'typeofsport=Men%2527s%2BTennis&division=Division+1&region=1.+Northeast&state=&typeofschool=&enrollment=&tuition1=&actscore=&satscore=&gpa=&classrank=&-max=100&-find=Find+Your+Colleges' --compressed



