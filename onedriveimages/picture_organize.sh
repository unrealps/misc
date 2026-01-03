#!/bin/bash

MONTH_NAME=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

IFS=$'\n' # Set Internal Field Separator to newline

LAST_FNAME=""
COUNT=0

for file in $(find "/home/psousa/winhome/OneDrive/Images/Imagens da Câmara" -type f -name "*jpg" -o -name "*JPG" -o -name "*jpeg" -o -name "*.heic" -o -name "*.png")
do
	echo "Processing file: ${file}"
	DATETIME=$(identify -verbose "${file}" |grep DateTimeOriginal | sed -e "s/^\s*//g" | cut -d' ' -f2-3)

        if [ -z ${DATETIME} ]
	then
		DATETIME=$(identify -verbose "${file}" |grep "exif:DateTime:" | sed -e 's/^ *//g' | cut -d' ' -f2-3)
	fi

        if [ -z ${DATETIME} ]
	then
		DATETIME=$(identify -verbose "${file}" |grep "date:modify:" | sed -e 's/^ *//g' | cut -d' ' -f2-3)

		if ! [ -z ${DATETIME} ]
		then
			DATETIME=$(echo ${DATETIME} | sed -e 's/T/ /g')
			DATETIME=$(echo ${DATETIME} | sed -e 's/-/:/g')
			DATETIME=$(echo ${DATETIME} | sed -e 's/\+.*$//g')
		fi
	fi

	if [ -z ${DATETIME} ]
        then
                DATETIME=$(stat "${file}" | grep "Modify:"  | head -1 | sed -e 's/^ *//g' | tr -s ' ' | cut -d' ' -f2-3 | sed -e 's/ /T/g' )
		DATETIME=$(echo ${DATETIME} | sed -e 's/T/ /g')
		DATETIME=$(echo ${DATETIME} | sed -e 's/-/:/g')
		DATETIME=$(echo ${DATETIME} | sed -e 's/\+.*$//g')
		DATETIME=$(echo ${DATETIME} | cut -d'.' -f1)
        fi


  	if ! [ -z ${DATETIME} ]
	then
		DATE=$(echo $DATETIME|cut -d' ' -f1)
		TIME=$(echo $DATETIME|cut -d' ' -f2)

		FDATE=$(echo $DATE | sed 's/:/-/g')
		FTIME=$(echo $TIME | sed 's/:/./g')

		YEAR=$(echo ${DATE}|cut -d':' -f1)
		MONTH=$(echo ${DATE}|cut -d':' -f2)
		MNAME="${MONTH_NAME[$(expr ${MONTH} - 1 )]}"

		FNAME=$(printf "IMG_%s_%s" ${FDATE} ${FTIME})
		if [ "${LAST_FNAME}" != "${FNAME}" ]
		then
			COUNT=0
			LAST_FNAME=${FNAME}
		else
			COUNT=$((COUNT + 1))
		fi
		if [ -z "$(echo ${file}|grep -i -e .heic)" ]
		then
			if [ -z "$(echo ${file}|grep -i -e .png)" ]
			then
				FNAME=$(printf "%s_%03d.jpg" ${FNAME} ${COUNT})
			else
				FNAME=$(printf "%s_%03d.png" ${FNAME} ${COUNT})
			fi
		else
			FNAME=$(printf "%s_%03d.heic" ${FNAME} ${COUNT})
		fi
		echo "Move file from: $file to: /home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})/${FNAME}"
		mkdir -p "/home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})"
		mv -f $file "/home/psousa/winhome/OneDrive/Images/${YEAR}/${YEAR}-${MONTH} (${MNAME})/${FNAME}"
#		sleep 1
	fi 
done
unset IFS # Reset IFS to default
