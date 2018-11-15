#!/bin/bash

zonadirecta=db.iesgn.org

if [ $1 = "-a" ]
then
	if [ $2 = "-dir" ]
	then
		echo "$3	IN	A	$4" >> $zonadirecta
	elif [ $2 = "-alias" ]
	then
		echo "$3	IN	CNAME	$4"
	else
		echo "Paramentros incorrectos."
	fi
elif [ $1 = "-b" ]
then
	echo "Borrar"
else
	echo "Incorrecto"
fi
