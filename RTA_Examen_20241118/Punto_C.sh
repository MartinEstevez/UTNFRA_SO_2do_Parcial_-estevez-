#!/bin/bash
PATH_DOCKER="/$HOME/UTNFRA_SO_2do_Parcial_estevez/202406/docker"
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
cat <<EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

echo "Creamos la imagen"

docker build -t martinestevez/web1-estevez:latest .

echo "pusheamos la imagen"

docker push martinestevez/web1-estevez:latest

docker images

sudo chmod 777 run.sh
./run.sh

echo "Testeamos"

sudo docker ps
