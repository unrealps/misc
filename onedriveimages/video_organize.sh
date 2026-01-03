#!/bin/bash

MONTH_NAME=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

IFS=$'\n' # Set Internal Field Separator to newline

LAST_FNAME=""
COUNT=0

for file in $(find "/home/psousa/winhome/OneDrive/Images/Imagens da Câmara" -type f -name "*mp4" -o -name "*m4v" -o -name "*MP4" -o -name "*.MOV")
do
	DATETIME=$(ffprobe "${file}" 2>&1 |grep creation_time | head -1 | sed -e 's/^ *//g' | tr -s ' ' | cut -d' ' -f3 )
	
	if [ -z ${DATETIME} ]
	then
		DATETIME=$(stat "${file}" | grep "Modify:"  | head -1 | sed -e 's/^ *//g' | tr -s ' ' | cut -d' ' -f2-3 | sed -e 's/ /T/g' )

	fi 

  	if ! [ -z ${DATETIME} ]
	then
		DATE=$(echo $DATETIME|cut -d'T' -f1)
		TMPTIME=$(echo $DATETIME|cut -d'T' -f2)
		TIME=$(echo $TMPTIME|cut -d'.' -f1)

		FDATE=$(echo $DATE | sed 's/:/-/g')
		FTIME=$(echo $TIME | sed 's/:/./g')

		YEAR=$(echo ${DATE}|cut -d'-' -f1)
		MONTH=$(echo ${DATE}|cut -d'-' -f2)
		MNAME="${MONTH_NAME[$(expr ${MONTH} - 1 )]}"

		FNAME=$(printf "VID_%s_%s" ${FDATE} ${FTIME})
		if [ "${LAST_FNAME}" != "${FNAME}" ]
		then
			COUNT=0
			LAST_FNAME=${FNAME}
		else
			COUNT=$((COUNT + 1))
		fi
		
		if [ -z "$(echo ${file} | grep -i -e .mov)" ]
		then
			FNAME=$(printf "%s_%03d.mp4" ${FNAME} ${COUNT})
		else
			FNAME=$(printf "%s_%03d.mov" ${FNAME} ${COUNT})
		fi
		echo "Move file from: $file to: /home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})/${FNAME}"
		mkdir -p "/home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})"
		mv -f $file "/home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})/${FNAME}"
#		sleep 1
	fi 
done
unset IFS # Reset IFS to default
