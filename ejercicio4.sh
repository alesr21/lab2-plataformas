#!/bin/bash


#Directorio por monitorear
direc="/home/alesol/lab2/servicios/para_monitorear"

#archivo de texto donde se registraran los cambios
registro_log="/home/alesol/lab2/servicios/registro_log.txt"


#Iniciando el proceso de monitoreo

echo "Comenzando el proceso de monitorizacion en el directorio: '$direc'"

#Monitorear cambios con un bucle while, utilizando inotifywait


inotifywait -r -e create -e modify -e delete "$direc" --format '%T %w %f %e' --timefmt '%Y-%m-%d %H:%M:%S'|
while read fecha hora directorio archivo evento; do
	#Recibir la fecha y hora en la que se detecto un cambio
	echo "$fecha $hora $evento en $directorio $archivo - Se resgistro un cambio en el directorio '$direc'" >> "$registro_log" 
done
