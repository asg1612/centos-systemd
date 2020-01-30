FROM centos:7

ENV container docker

RUN cd /lib/systemd/system/sysinit.target.wants/; \
    for i in *; do [ $i = systemd-tmpfiles-setup.service ] || rm -f $i; done

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/*


# Docker
RUN yum remove docker \
               docker-client \
               docker-client-latest \
               docker-common \
               docker-latest \
               docker-latest-logrotate \
               docker-logrotate \
               docker-engine

RUN yum install -y yum-utils \
                   device-mapper-persistent-data \
                   lvm2

RUN yum-config-manager --add-repo \
                       https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install -y docker-ce docker-ce-cli containerd.io

# RUN yum install -y epel-release @Development tools python-devel python3-devel python-pip
# RUN pip install -y docker docker-compose


VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
