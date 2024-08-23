## README
## O parâmetro -v /var/run/docker.sock:/var/run/docker.sock monta o socket Docker do host dentro do contêiner, permitindo que o Jenkins interaja com o Docker no host.

##  O comando -v /var/jenkins_home:/var/jenkins_home no contexto do Docker é usado para montar um volume no contêiner, o que significa que ele cria uma ligação entre um diretório no host (/var/jenkins_home) e um diretório dentro do contêiner (também /var/jenkins_home). Vamos detalhar sua finalidade:

## Propósito do Volume:

## Persistência de Dados:

## O Jenkins armazena dados críticos como configurações, logs, plugins e arquivos de trabalho no diretório /var/jenkins_home dentro do contêiner.
## Ao montar o volume -v /var/jenkins_home:/var/jenkins_home, você garante que esses dados sejam persistidos no host, mesmo que o contêiner seja removido ou recriado. Dessa forma, os dados do Jenkins não são perdidos e podem ser reutilizados em contêineres futuros.
## Facilidade de Backup e Recuperação:

## Como os dados do Jenkins estão persistidos no host, fica mais fácil realizar backups e recuperações. Você pode simplesmente copiar o diretório /var/jenkins_home do host para realizar um backup completo da configuração e dos dados do Jenkins.

## Atualização do Jenkins:
## Se você precisar atualizar ou substituir o contêiner do Jenkins, pode fazê-lo sem perder os dados existentes. Basta iniciar um novo contêiner Jenkins ## ## ## montando o mesmo volume, e ele continuará de onde parou.

## EXECUCAO DO CONTAINER ## 
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins-container \
  jenkins/jenkins:lts-alpine