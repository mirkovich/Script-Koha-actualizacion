#!/bin/sh

# script para actualizar koha en caso de que hayan actualizaciones disponibles
# recordar que tenemos que actualizar koha de koha.dev

apt-get update

versionkohaandactualizacion=  $(apt list --upgradable koha* -a)

# si no tengo actualizaciones para koha no hago nada de nada.
if -z versionkohaandactualizacion
  then echo "No hay actualizaciones recientes para koha."

else
# si estamos aca hay una actualizacion disponible, entonces la realizamos
# apt list --upgradable koha* -a devuelve algo de la pinta:
#Listando... Hecho
#koha-common/stable 18.11.00-4 all [actualizable desde: 17.05.02-1]       ---> version stable actual
#koha-common/now 17.05.02-1 all [instalado, actualizable a: 18.11.00-4]   ---> version en uso

# TOMA DE DECISIÓN
# TENEMOS DOS OPCIONES:
#       apt-get upgrade                   ----> en este caso koha-common se va a entrontrar retenido.
#                                             (* hay una posible solución ---> apt-get dist-upgrade)
#       apt-get upgrade koha-common       ----> en este caso no (creo que lo fuerzo)

# usamos la primer opción --y responde automaticamente yes a
  actualizacion = $(apt-get dist-upgrade --y)
# una vez "instalado" este puede fallar o no de todas formas hay q notificar el resultado de la misma
# vamos a notificar  via mail por medio de Mint
# en caso que no esté instalado correr sudo apt-get install mailutils

  mail -s "Actualización de Koha en koha.dev" sistemas@bl.fcen.uba.ar <<< $actualizacion
