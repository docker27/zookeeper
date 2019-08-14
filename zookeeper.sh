#!/bin/bash

downloan_url='http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz'
downloan_file_name='zookeeper-3.4.12.tar.gz'
install_dir='/usr/local/zookeeper'
zookeeper_home='/usr/local/zookeeper/zookeeper-3.4.12'
zookeeper_md5='f43cca610c2e041c71ec7687cddbd0c3';

# init
function _init() {
	mkdir -p /usr/local/zookeeper /opt/zookeeper/data/ /opt/zookeeper/logs/
	rm -rf /usr/local/zookeeper/*
}

# install
function _install() {
	if [ ! -f /opt/install/${downloan_file_name} ]; then
                echo "zookeeper tar not exist !!!"
		exit -1
        fi
	md5=`md5sum /opt/install/${downloan_file_name} | awk -F ' ' '{print $1}'`
        if [ $md5 != $zookeeper_md5 ]; then
                echo "zookeeper tar md5 incorrect !!!"
                exit -1
        fi
	if [ ! -d /usr/local/zookeeper/zookeeper-3.4.12/ ]; then
		tar -zxvf /opt/install/${downloan_file_name} -C /usr/local/zookeeper
	fi
	cp /opt/install/zoo.cfg ${zookeeper_home}/conf/
	chown -R dev:dev /usr/local/zookeeper/
	chown -R dev:dev /opt/zookeeper/data/
	chown -R dev:dev /opt/zookeeper/logs/
	
	echo "zookeeper install success !!!"
}

# start zookeeper
function _start() {
	su - dev -c 'sh ${zookeeper_home}/bin/zkServer.sh start'
	echo "zookeeper start success !!!"
}

# chkconfig 设置开机启动
function _chkconfig() {
	cd /etc/rc.d/init.d/
	rm -rf /etc/rc.d/init.d/zookeeper 
	touch /etc/rc.d/init.d/zookeeper
	chmod +x /etc/rc.d/init.d/zookeeper
	echo "#!/bin/bash" >> /etc/rc.d/init.d/zookeeper
	echo "# chkconfig: 12345 95 05" >> /etc/rc.d/init.d/zookeeper

	echo "su - dev -c 'sh ${zookeeper_home}/bin/zkServer.sh start'" >> /etc/rc.d/init.d/zookeeper
	chkconfig --add zookeeper
	echo "chkconfig add zookeeper success"
}

_init
_install
_start
_chkconfig
