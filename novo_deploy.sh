#!/bin/bash

cd /home/centos

[ -d integration-pr ] || git clone git@github.com:youse-seguradora/integration-pr.git

echo Entrando no diretorio do app...
cd integration-pr
git checkout master

echo Matando os containers em execucao...
docker rm -f $(docker ps -aq)

echo Removendo persistencia do banco
sudo rm -rf storage/*

echo Recebendo updates do Github
git pull

echo Iniciando o stack principal
./start_environment.sh

echo Iniciando API de testes
./run-demo-api.sh start

echo Iniciando o Swagger
bash ~/run_swaggers.sh

echo Fim. 
docker ps
