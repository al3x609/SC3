FROM centos:latest

LABEL name="Proyect SC3 [Visualización de Fluidos Mediante Técnicas de Dinámica de Fluidos Computacionales Sobre Máquinas Mas                                 ivamente Paralelas Basadas en GPU$
    vendor="UIS <Universidad Industiral de Santander>" \
    Description="Imagen base +  VirtualGL + ParaView-5 "\
    license="Private" \
    version="1.0" \
    MAINTAINER="Cesar Bernal <csrbernal609@gmail.com>" \
    build-date="20180322"

ENV NVIDA_RUN 'http://us.download.nvidia.com/XFree86/Linux-x86_64/367.124/NVIDIA-Linux-x86_64-367.124.run'
ENV VIRTUALGL_RUN 'https://sourceforge.net/projects/virtualgl/files/2.5.2/VirtualGL-2.5.2.x86_64.rpm'

WORKDIR /opt

RUN yum -y update; yum clean all && \
    yum install -y       \
        wget             \
        libXt            \
        libSM            \
        deltarpm         \
        qt5-qtbase-gui   \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm  && \
        \
        #configuracion openbox
                yum install -y openbox && \
                # configuracion nvida applications
        wget -L $NVIDA_RUN  && \
        chmod +x NVIDIA-Linux-x86_64-367.124.run && \
        ./NVIDIA-Linux-x86_64-367.124.run --no-kernel-module-source -z --no-kernel-module -N -b -a -s -q --no-x-check && \
        nvidia-xconfig -a --use-display-device=none --virtual=1920x1200 && \
        \
        # configuracion VirtualGL
            curl -SL $VIRTUALGL_RUN -o VirtualGL-2.5.2.x86_64.rpm && \
            yum -y --nogpgcheck localinstall VirtualGL-2.5.2.x86_64.rpm  && \
            /opt/VirtualGL/bin/vglserver_config -config +s +f -t && \
        \
    # Clean Seccion
        rm NVIDIA-Linux-x86_64-367.124.run && \
        rm VirtualGL-2.5.2.x86_64.rpm      && \
        rm -r /usr/share/info/*            && \
            rm -r /usr/share/man/*             && \
            rm -r /usr/share/doc/*             && \
            find /. -name "*~" -type f -delete && \
            yum clean all                      && \
            rm -rf /var/cache/yum
            
ADD ./packages/ParaView.tar.gz /opt

ENV VIRTUALGL_VERSION 2.5.2
ENV PATH /opt/VirtualGL/bin:${PATH}
ENV PARAVIEW_VERSION 5.5.0-MPI-Linux-64bit
ENV PATH /opt/ParaView/bin:${PATH}

CMD ["/bin/bash"]

