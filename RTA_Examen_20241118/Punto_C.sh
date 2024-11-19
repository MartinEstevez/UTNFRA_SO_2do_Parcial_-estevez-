#!/bin/bash
PATH_DOCKER="/home/martinestevez/repogit/UTN-FRA_SO_Examenes/202406/docker"
cd $PATH_DOCKER

cat > index.html << EOF
<div>
<h1> Sistemas Operativos - UTNFRA </h1><br>
<h2> 2do Parcial - Noviembre 2024 </h2><br>
<h3> Martin Estevez </h3>
<h3> División: 311 </h3>
</div>
EOF

echo "Creamos dockerfile"
cat << EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

echo "Creamos la imagen"

docker build -t martinestevez/web1-estevez:latest .

echo "pusheamos la imagen"

docker push martinestevez/web2-estevez:latest

docker images

# se agrega el usuario al grupo docker

sudo usermod -aG docker martinestevez

# INICIAR SESION

sudo docker login -u martinestevez

docker tag web2-estevez martinestevez/web2:latest

echo "Creando el archivo run.sh"
cat << EOF > run.sh
#!/bin/bash
docker run -d -p 8081:80 martinestevez/web2-estevez:latest
EOF

sudo chmod 777 run.sh
sudo ./run.sh

echo "Testeamos"

sudo docker ps
