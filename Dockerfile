FROM jenkins/jenkins:2.60.3

LABEL Author="Denis Silveira"

ARG master_image_version="v.3.1.0"
ENV master_image_version $master_image_version

ENV KUBERNETES_SERVER_URL "http://kubernetes:8443"
ENV JENKINS_SERVER_URL "http://jenkins:8080"

USER jenkins
# Futuramente deixe estes downloads a criterio de seu gerenciador de artefatos
COPY downloads/*.tar.gz /var/jenkins_home/downloads/

# Plugins Install
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Auto Setup Scripts
COPY src/main/groovy/* /usr/share/jenkins/ref/init.groovy.d/
COPY src/main/resources/*.properties /var/jenkins_home/config/
COPY src/main/resources/initials/*.file /var/jenkins_home/config/initials/

# Para configuracoes de Seguranca
COPY src/main/resources/initials/*.txt /var/jenkins_home/.ssh/
