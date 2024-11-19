#!/bin/bash

ssh-keygen -t ed25519
cat /home/$(whoami)/.ssh/id_ed25519.pub >> /home/$(whoami)/.ssh/authorized_keys


# Creamos la estructura

mkdir -p /tmp/2do_parcial/alumno
mkdir -p /tmp/2do_parcial/equipo

mkdir /home/martinestevez/repogit/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/templates

cd /home/martinestevez/repogit/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/templates

touch datos_alumno.j2
vim datos_datos_alumno.j2
Nombre: {{ nombre }}
Apellido: {{ apellido }}
Division: {{ division }}

vim /home/martinestevez/repogit/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/tasks

- name: Generar archivo para alumno
  template:
    src: datos_alumno.j2
    dest: /tmp/2do_parcial/alumno/datos_alumno.txt
  vars:
    Nombre: "TuNombre" Apellido: "TuApellido"
    Division: "TuDivision"

- name: Generar archivo para equipo
  template:
    src: datos_equipo.j2
    dest: /tmp/2do_parcial/equipo/datos_equipo.txt
  vars:
    ip: "TuIP"
    distro: "TuDistribucion"
    cores: "TuCantidadDeCores"

ansible-playbook -i inventory playbook.yml

# CONFIGURAR SUDOERS PARA GRUPO 2PSupervisores

sudo visudo

sudo groupadd 2PSupervisores
udo usermod -aG 2PSupervisores martinestevez
