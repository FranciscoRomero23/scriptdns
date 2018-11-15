#!/bin/bash

zonadirecta=db.iesgn.org
zonainversa=db.192.168.10

if [ $1 = "-a" ]
then
	if [ $2 = "-dir" ]
	then
		ip=`echo $4 | cut -d"." -f4`
		dominio=`sed -e '/ORIGIN/ !d' $zonadirecta | cut -d" " -f2`

		echo "$3	IN	A	$4" >> $zonadirecta
		echo "$ip	IN	PTR	$3.$dominio" >> $zonainversa
	elif [ $2 = "-alias" ]
	then
		echo "$3	IN	CNAME	$4" >> $zonadirecta
	else
		echo "Paramentros incorrectos."
	fi
elif [ $1 = "-b" ]
then
	sed -i '/'${2}'/d' $zonadirecta
else
	echo "Incorrecto"
fi
