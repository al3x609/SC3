FROM centos:latest

LABEL name="Proyect SC3 [Visualización de Fluidos Mediante Técnicas de Dinámica de Fluidos Computacionales Sobre Máquinas Mas                             ivamente Paraa
lelas Basadas en GPUs]" \
    vendor="UIS <Universidad Industiral de Santander>" \
    Description="Imagen base +  openbox + novnc + websockify "\
    license="Private" \
    version="1.0" \
    MAINTAINER="Cesar Bernal <csrbernal609@gmail.com>" \
    build-date="20180322"

ENV REPO_NOVNC 'https://github.com/kanaka/noVNC.git'
ENV REPO_WEBSOCKIFY 'https://github.com/kanaka/websockify'
ENV REPO_OPENBOX 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'

WORKDIR /
COPY setup.sh /

RUN yum -y update; yum clean all && \
    yum install -y       \
        numpy            \
        wget             \
        git              \
        unzip            \
        which            \
        net-tools        \
        $REPO_OPENBOX && \
#configuracion openbox
    yum install -y openbox && \
    cd /opt && git clone $REPO_NOVNC && \
    cd noVNC/utils && git clone $REPO_WEBSOCKIFY websockify && \
# permisos script inicio noVNC
    cd / && chmod 0755 /setup.sh && \
    cd /opt/noVNC && ln -s vnc.html index.html && \
# Clean Seccion
    rm -r /usr/share/info/*            && \
    rm -r /usr/share/man/*             && \
    rm -r /usr/share/doc/*             && \
    find /. -name "*~" -type f -delete && \
    yum clean all                      && \
    rm -rf /var/cache/yum

ENV PATH "/:${PATH}"
