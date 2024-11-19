#!/bin/bash

cd /usr/local/bin

#CREACION DEL SCRIPT Y PERMISOS

sudo touch EstevezAltaUser-Groups.sh

sudo chmod 777 EstevezAltaUser-Groups.sh

#PARAMETRO 1: USUARIO DEL CUAL SE OBTENDRA LA CLAVE

USER_REF=$1

#PARAMETRO 2: /home/martinestevez/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt

LISTA_USUARIOS=$2

PASS_USUARIOS=$(sudo cat /etc/shadow | grep "$1" | awk -F ':' '{print $2}')

USUARIO_1=$(grep Prog1 $LISTA_USUARIOS | awk -F ',' '{print $1}')
USUARIO_2=$(grep Prog2 $LISTA_USUARIOS | awk -F ',' '{print $1}')
USUARIO_3=$(grep Test1 $LISTA_USUARIOS | awk -F ',' '{print $1}')
USUARIO_4=$(grep Supervisor $LISTA_USUARIOS | awk -F ',' '{print $1}')

GRUPO_PROG=$(grep Prog1 $LISTA_USUARIOS | awk -F ',' '{print $"}')
GRUPO_TESTERS=$(grep Test1 $LISTA_USUARIOS | awk -F ',' '{print $"}')
GRUPO_SUPERVISORES=$(grep Supervisor $LISTA_USUARIOS | awk -F ',' '{print $"}')

RUTA_USER1=$(grep Prog1 $LISTA_USUARIOS | awk -F ',' '{print $3}')
RUTA_USER2=$(grep Prog2 $LISTA_USUARIOS | awk -F ',' '{print $3}')
RUTA_USER3=$(grep Test1 $LISTA_USUARIOS | awk -F ',' '{print $3}')
RUTA_USER4=$(grep Supervisor $LISTA_USUARIOS | awk -F ',' '{print $3}')

sudo groupadd -m -d "$RUTA_USER1" -s /bin/bash -c "User Prog1" -G $GRUPO_PROG -p "$PASS_USUARIOS" $USUARIO_1

sudo groupadd -m -d "$RUTA_USER2" -s /bin/bash -c "User Prog2" -G $GRUPO_PROG -p "$PASS_USUARIOS" $USUARIO_2

sudo groupadd -m -d "$RUTA_USER3" -s /bin/bash -c "User Test1" -G $GRUPO_TESTERS -p "$PASS_USUARIOS" $USUARIO_3

sudo groupadd -m -d "$RUTA_USER4" -s /bin/bash -c "User Supervisor" -G $GRUPO_SUPERVISORES -p "$PASS_USUARIOS" $USUARIO_4

echo "Probando script"

ls -l /work/

ls -l /usr/local/bin/
