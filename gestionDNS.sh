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
	dominio=`sed -e '/ORIGIN/ !d' $zonadirecta | cut -d" " -f2`
	registro=`sed -e '/'${2}'/ !d' db.iesgn.org | cut -f3 -s`

	sed -i '/'${2}'/d' $zonadirecta
	if [ $registro != "CNAME" ]
	then
		sed -i '/'${2}.${dominio}'/d' $zonainversa
	fi
elif [ $1 = "-zone" ]
then
	if [ $2 = "-direct" ]
	then
		zonaoriginal=`grep zonadirecta gestionDNS.sh | head -1`
		sed -i '3 s/'${zonaoriginal}'/zonadirecta='${3}'/g' gestionDNS.sh
	elif [ $2 = "-reverse" ]
	then
                zonaoriginal=`grep zonainversa gestionDNS.sh | head -1`
                sed -i '4 s/'${zonaoriginal}'/zonainversa='${3}'/g' gestionDNS.sh
	fi
else
	echo "Parametros incorrectos"
fi
