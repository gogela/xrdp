A simlple RDP honeypot based on xrdp 0.9.13 - see the original repo @ neutrinolabs/xrdp for all details of the original

changes:
- xrdp_mm.c - now logs credentials to syslog
to get it from syslog use something like: cat /var/log/xrdp.log |grep logged

build :

git clone https://github.com/gogela/xrdp.git
ls
cd xrdp
apt get ssl-devel
apt install ssl-devel
apt-get install git autoconf libtool pkg-config gcc g++ make  libssl-dev libpam0g-dev libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev  flex bison libxml2-dev intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev
./bootstrap
./configure
make
make install
xrdp
#mke cert so the TLS works
xrdp-keygen xrdp auto
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365

#copy this repo /etc/xrdp.ini to actual /etc/xrdp/xrdp.inihistory |less 

#use tshark to get TLS hellos for JA3 extraction
apt install tshark
mkdir tshark_logs

#run tshark in 'rotating buffer' mode




#get ja3 to calculate hashes
git clone https://github.com/salesforce/ja3.git
cd ja3
cd python/
pip install dpkt


#have a script (monitor.sh) to get JA3 hashes from the captured client hello packets
#!/bin/sh
MONITORDIR="/root/tshark_logs/"
FINISHED=""
inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "File ${NEWFILE} has been created"
        if [ -z "$FINISHED" ]
        then
                echo "First file - nothing to JA3 process"
        else
                echo "Processing ${FINISHED}"
                /root/ja3/python/ja3.py -a -j  "${FINISHED}" >> /root/ja3.result
        fi
        FINISHED=$NEWFILE


done


#run it all (use screen for each):
xrdp

run monitor of pcaps:
./monitor.sh

run tshark
cd ~/tshark_logs
tshark -w outfile.pcap -b files:10 -b filesize:100  tcp port 3389

results in
~/ja3.results


