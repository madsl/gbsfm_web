#!/bin/sh

# - Ensure no relevent processes are still running:
killall sc_serv
echo "sc_serv killed"
sleep 1
killall manage.py
sleep 1
killall python
echo "All python-related processes killed"
sleep 1
killall ices
echo "ices killed"
sleep 1

export PYTHONPATH="/home/jonnty/pydj"
export DJANGO_SETTINGS_MODULE="pydj.settings"
echo "Various variables exported"
sleep 1

cd ~jonnty/pydj
echo "Starting the main web interface"
./manage.py runfcgi method=prefork socket=/tmp/fcgi.sock maxrequests=500 maxchildren=7
echo "Main web interface started"
sleep 1  

cd ~jonnty/pydj/playlist
nohup python ftp.py &
echo "FTP-server started"
sleep 1

#cd /home/g3/sc_serv
#nohup ./sc_serv sc_serv.conf &
#echo "sc_serv started"
#echo "Now start the stream using the webpage"
