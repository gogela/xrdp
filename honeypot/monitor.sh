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
