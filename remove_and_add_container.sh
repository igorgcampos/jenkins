#!/bin/bash

# Passo 1: Obter o nome do contêiner Jenkins em execução
CONTAINER_NAME=$(docker ps --filter "name=jenkins" --format "{{.Names}}")

# Verifica se o contêiner está em execução
if [ -z "$CONTAINER_NAME" ]; then
    echo "Nenhum contêiner Jenkins em execução encontrado."
    exit 1
fi

echo "Contêiner em execução encontrado: $CONTAINER_NAME"

# Passo 2: Pausar e remover o contêiner
echo "Pausando o contêiner..."
docker stop "$CONTAINER_NAME"

echo "Removendo o contêiner..."
docker rm "$CONTAINER_NAME"

# Passo 3: Construir uma nova imagem Docker com o Dockerfile atualizado
echo "Construindo a nova imagem Docker..."
docker build -t jenkins .

# Passo 4: Executar um novo contêiner Jenkins com a nova imagem
echo "Iniciando um novo contêiner com o nome $CONTAINER_NAME..."
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add docker \
  --name "$CONTAINER_NAME" \
  jenkins

echo "Novo contêiner Jenkins iniciado com sucesso."