# Usar uma imagem base mínima
FROM jenkins/jenkins:alpine3.20-jdk21

# Definir o usuário root para instalação de dependências
USER root

# Atualizar pacotes e instalar dependências mínimas
RUN apk add --no-cache \
    git \
    docker \
    curl \
    bash \
    openjdk11-jre

# Configurar Jenkins para rodar como um usuário não-root
RUN addgroup -S jenkins && adduser -S jenkins -G jenkins
RUN mkdir -p /var/jenkins_home /usr/share/jenkins/ref/init.groovy.d \
    && chown -R jenkins:jenkins /var/jenkins_home /usr/share/jenkins

# Configurar variáveis de ambiente
ENV JENKINS_HOME /var/jenkins_home
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Instalar plugins básicos (apenas os necessários)
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Configurar permissão do diretório de trabalho
WORKDIR /var/jenkins_home

# Expôr a porta 8080 e 50000 para uso do Jenkins
EXPOSE 8080
EXPOSE 50000

# Configurar Jenkins para rodar como o usuário jenkins
USER jenkins

# Definir o comando padrão
CMD ["jenkins.sh"]
