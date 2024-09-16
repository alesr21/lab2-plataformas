#!/bin/bash

#Verificar que se ingreso el nombre del proceso y el comando para ejecutarlo
if [ $# -ne 2 ]; then
 	echo "Debe ingresar como argumento el nombre del proceso y el comando para ejecutarlo"
        exit 1
fi

#Guardar los parametros ingresados como variables

nombre_del_proceso=$1
comando_para_ejecutar=$2

#Funcion para saber si el proceso esta siendo ejecutado

proceso_ejecutandose() {
	
	if pgrep -x "$nombre_del_proceso" > /dev/null 2>&1; then
                echo "Proceso '$nombre_del_proceso' en ejecucion"

        else
                $comando_para_ejecutar & #abre el proceso
                echo "Proceso '$nombre_del_proceso' no encontrado. Reiniciando..."
        fi

}

#Para monitorear el proceso se utiliza while que va revisando periodicamente

echo "Si desea cancelar el proceso, ingrese ctrl+c"

while true; do
	proceso_ejecutandose
	sleep 5
done
		
