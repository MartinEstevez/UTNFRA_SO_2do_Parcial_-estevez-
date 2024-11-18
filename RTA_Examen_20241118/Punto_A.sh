#!/bin/bash

# PARTICIONAMOS LOS DISCOS

PDISCO_1G=$(lsblk | grep 1G | awk '{print $1}')

echo "Particionando Disco de 1G"

sudo fdisk /dev/$PDISCO_1G << EOF
n
p



t
8E
w
EOF

echo "Disco particionado"

echo "Limpiando la particion"

sudo wipefs -a /dev/${PDISCO_1G}1

PDISCO_2G=$(lsblk | grep 2G | head -n 1 | awk '{print $1}')

sudo fdisk /dev/$PDISCO_2G << EOF
n
p



t
8E
w
EOF

echo "Disco Particionado"

echo "Limpiando la particion"

sudo wipefs -a /dev/${PDISCO_2G}1

#CREAMOS LOS VOLUMENES FISICOS, GRUPOS DE VOLUMEN Y VOLUMENES LOGICOS

echo "Preparando PV, VG, LV"

sudo pvcreate /dev/${PDISCO_1G}1
sudo pvcreate /dev/${PDISCO_2G}1
sudo vgcreate vg_temp /dev/${PDISCO_1G}1
sudo vgcreate vg_datos /dev/${PDISCO_2G}1
sudo lvcreate -L 5M vg_datos -n lv_docker
sudo lvcreate -L 1.5G vg_datos -n lv_workareas
sudo lvcreate -L 512M vg_temp -n lv_swap

echo "Le damos formato"

sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap

echo "Montamos las particiones y reiniciamos el servicio de docker"

sudo mkdir /work/
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker

sudo systemctl restart docker

echo "Verificamos resultados"
df -h
lsblk
