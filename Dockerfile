FROM qianchun27/centos-jdk-maven:7.8.3

MAINTAINER qianchun, qianchun27@hotmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV BASE_INSTALL_DIR /opt/install

RUN mkdir -p ${BASE_INSTALL_DIR}

COPY zoo.cfg ${BASE_INSTALL_DIR}
COPY zookeeper.sh ${BASE_INSTALL_DIR}
COPY install.sh ${BASE_INSTALL_DIR}
COPY restart.sh ${BASE_INSTALL_DIR}
COPY zookeeper-3.4.12.tar.gz ${BASE_INSTALL_DIR}

RUN sh ${BASE_INSTALL_DIR}/install.sh
