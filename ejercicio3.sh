#!/bin/bash

#Recibir el ejecutable

if [ $# -eq 0 ];then
	echo "Debe ingresar como argumento el parametro ejecutable"
	exit 1
fi

#Variable
ejecutable=$1

#Crear el archivo log
archivo_log="consumo_cpu_mem.log"

#Encabezado del archivo log
echo "Fecha Hora,  %CPU, %Memoria" > $archivo_log

#Ejecutar el comando en segundo plano
$ejecutable &
pid=$!

while kill -0 $pid 2> /dev/null; do
	#Fecha y hora del proceso utilizando date
	fecha=$(date +"%Y/%m/%d %H:%M:%S")

	#Uso de CPU y memoria(utilizando ps)
	CPU=$(ps -p $pid -o %cpu --no-headers)
	memoria=$(ps -p $pid -o %mem --no-headers)

	#Enviar los datos anteriores al archivo log
	echo "$fecha, $CPU, $memoria" >> $archivo_log

	#Tiempo de espera antes de tomar el nuevo dato
	sleep 2

done

echo "Proceso exitoso.Los datos han sido guardados en $archivo_log"

#Para generar el grafico

gnuplot -persist <<-grafico
	set datafile separator ","
	set xdata time
	set timefmt "%Y/%m/%d %H:%M:%S"
	set format x "%H:%M:%S"
	set xlabel "Tiempo"
	set ylabel "Porcentaje(%)"
	set title "Consumo de CPU y Memoria"
	set term png
	set output "grafico_cpu_mem.png"
	plot "$archivo_log" using 1:2 with lines title "CPU",\
	     "$archivo_log" using 1:3 with lines title "Memoria" 
	
grafico

echo "Grafico generado:grafico_cpu_mem.png"

