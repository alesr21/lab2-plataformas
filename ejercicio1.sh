#!/bin/bash

#Verificar si se recibio el documento

if [ $# -ne 1 ]; then
	echo "Se debe brindar el ID del proceso como argumento"
	exit 1
fi


#Asignar el argumento como PID

PID=$1

#Se verifica si el PID existe

if ! ps -p $PID > /dev/null 2>&1; then
	echo "El PID $PID no se ha encontrado,ingrese un argumento correcto"
	exit 1

else 
	#Nombre del proceso
	nomb_proceso=$(ps -p $PID -o comm=)
	echo "a)El nombre del proceso es: $nomb_proceso"

	#ID del proceso
	echo "b)El ID del proceso es:$PID"

	#Parent process ID (proceso padre)
	parent_process=$(ps -p $PID -o ppid=)
	echo "c)El proceso padre o parent process ID es:$parent_process"

	#Usuario propietario
	user=$(ps -p $PID -o user=)
	echo "d)El usuario propietario del PID es:$user"

	#Uso de CPU al momento de correr el script
	cpu=$(ps -p $PID -o %cpu=)
	echo "e)El uso del %CPU del proceso es:$cpu"

	#Consumo de memoria
	memoria=$(ps -p $PID -o %mem=)
	echo "f)El consumo de memoria es:$memoria"

	#Estado del proceso
	estado=$(ps -p $PID -o stat=)
	echo "g)El estado(status) del proceso es:$estado"

	#Path del ejecutable
	path_ejecutable=$(ps -p $PID -o cmd=)
	echo "f)La ruta del ejecutable es:$path_ejecutable"

fi






