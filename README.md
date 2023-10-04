# Groovy Script

## Eliminación de solicitudes antiguas de Sistemas

Este script elimina los registros de las solicitudes hechas a Sistemas, que hayan sido realizadas dentro del rango de fechas establecido en el script.

Al ser muchos registros, hay una variable que indica la cantidad limite de registros a eliminar por cada vez que se ejecute el script.

Las trazas del script mostrarán los DDLRecordId de los registros que hayan sido eliminados.
Además al finalizar, indicará cuantos segundos tardó la ejecución del Script completo.

- El valor establecido en el Script es de **500** registros a eliminar por ejecución.


<sub>(Si el tiempo es muy breve o muy extenso, se puede modificar la variable '**limiteFilas**' al principio del script, para agilizar o aumentar el proceso)</sub>
