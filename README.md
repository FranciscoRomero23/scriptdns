# scriptdns
Script que nos permitira añadir o borrar nombres en un servidor dns

El nombre del script es gestionDNS.sh y recibe cuatro parámetros:

-a: Si recibe este parámetro, dara de alta un nuevo nombre.

-dir: Si recibe este parámetro, el nuevo registro será del tipo A.
 
-alias: Si recibe este parámetro, el nuevo registro será del tipo CNAME.

-b: Si recibe este parámetro, dara de baja un nombre.

Nueva función: definición de los archivos de zona

Con el script podremos definir cuales son los archivos de las zonas. Usando estos parametros:

-zone: Si recibe este parámetro, definiremos la zona.

-direct: Si recibe este parámetro, la zona que estaremos definiendo será la directa.

-reverse: Si recibe este parámetro, la zona que estaremos definiendo será la inversa.
