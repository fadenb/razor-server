FROM centos:6.8

# Following is required due to https://github.com/CentOS/sig-cloud-instance-images/issues/15
RUN yum install -y yum-plugin-ovl

# And we continue.
RUN yum -y update

RUN  rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm && \
     yum install -y puppet tar

ADD  razor-postgres-install.pp /
ADD  start.sh /

ENV  HOSTNAME       razor-server
ENV  TORQUEBOX_HOME /opt/razor-torquebox
ENV  JBOSS_HOME     $TORQUEBOX_HOME/jboss
ENV  JRUBY_HOME     $TORQUEBOX_HOME/jruby
ENV  PATH           $JRUBY_HOME/bin:$PATH

RUN  puppet module install puppetlabs/postgresql

RUN yum install -y razor-server && \
    gem install razor-client

ADD config.yaml /etc/razor/config.yaml
VOLUME /opt/custom-tasks

RUN mkdir -p /scripts

ADD install_microkernel.sh /scripts/
ADD setup_postgres.sh /scripts/

RUN /scripts/setup_postgres.sh
RUN /scripts/install_microkernel.sh

# 69      TFTP
# 8080	Torquebox API

EXPOSE    8080

RUN  chmod +x /start.sh
CMD  ["/start.sh"]
