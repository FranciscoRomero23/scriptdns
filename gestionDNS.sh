#!/bin/bash

#Los archivos de las zonas estan indicados en estas dos variables
zonadirecta=db.iesgn.org
zonainversa=db.192.168.10

#Con el parametro -a añadimos registros
if [ $1 = "-a" ]
then
	if [ $2 = "-dir" ]
	then
		ip=`echo $4 | cut -d"." -f4`
		dominio=`sed -e '/ORIGIN/ !d' $zonadirecta | cut -d" " -f2`

		#Insertamos los nuevos registros en las zonas directa e inversa
		echo "$3	IN	A	$4" >> $zonadirecta
		echo "$ip	IN	PTR	$3.$dominio" >> $zonainversa
	elif [ $2 = "-alias" ]
	then
		#Insertamos los nuevos registros en la zona directa
		echo "$3	IN	CNAME	$4" >> $zonadirecta
	else
		echo "Paramentros incorrectos."
	fi
#Con el parametro -b borramos registros
elif [ $1 = "-b" ]
then
	#Obtenemos el dominio y el tipo de registro para poder hacer una correcta elimininación del registro
	dominio=`sed -e '/ORIGIN/ !d' $zonadirecta | cut -d" " -f2`
	registro=`sed -e '/'${2}'/ !d' db.iesgn.org | cut -f3 -s`
	#Borramos el registro de la zona directa
	sed -i '/'${2}'/d' $zonadirecta
	#Si el registro es de tipo CNAME, no existe dentro de la zona inversa
	if [ $registro != "CNAME" ]
	then
		sed -i '/'${2}.${dominio}'/d' $zonainversa
	fi
#Con el parametro -zone definimos los archivos de las zonas
elif [ $1 = "-zone" ]
then
	#Con el parametro -direct indicamos la zona directa
	if [ $2 = "-direct" ]
	then
		zonaoriginal=`grep zonadirecta gestionDNS.sh | head -1`
		sed -i '3 s/'${zonaoriginal}'/zonadirecta='${3}'/g' gestionDNS.sh
	#Con el parametro -reverse indicamos la zona inversa
	elif [ $2 = "-reverse" ]
	then
                zonaoriginal=`grep zonainversa gestionDNS.sh | head -1`
                sed -i '4 s/'${zonaoriginal}'/zonainversa='${3}'/g' gestionDNS.sh
	fi
else
	echo "Parametros incorrectos"
fi
