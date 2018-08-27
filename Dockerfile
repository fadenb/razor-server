FROM fadenb/torquebox:3.2.0
USER root

RUN yum -y update
ADD https://s3.amazonaws.com/jruby.org/downloads/9.1.17.0/jruby-bin-9.1.17.0.zip /root/jruby.zip
WORKDIR /root

RUN unzip jruby.zip && \
    mv /root/jruby-9.*/bin/* /usr/local/bin/ && \
    mv /root/jruby-9.*/lib/* /usr/local/lib/ && \
    rm -fr /root/jruby-9.*

RUN  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && \
     yum install -y puppet tar && yum clean all

ADD  start.sh /

ENV  HOSTNAME       razor-server
ENV  TORQUEBOX_HOME /opt/razor-torquebox
ENV  JBOSS_HOME     $TORQUEBOX_HOME/jboss
ENV  JRUBY_HOME     $TORQUEBOX_HOME/jruby
ENV  PATH           $JRUBY_HOME/bin:$PATH

RUN  yum install -y git && yum clean all && \
     gem install bundler

RUN yum install -y wget libarchive-devel && yum clean all

WORKDIR /opt

ADD https://github.com/puppetlabs/razor-server/archive/1.9.2.zip /opt/1.9.2.zip
RUN unzip 1.*.zip && mv razor-server-1.* razor-server && \
    cd razor-server

# Overriding
ADD config.yaml /opt/razor-server/config.yaml

WORKDIR /opt/razor-server

RUN sed -i 's/2.3.1/2.3.3/; s/9.1.5.0/9.1.17.0/' Gemfile

RUN bundle install && \
    mkdir -p /var/lib/razor/repo-store &&  \
    mkdir -p /scripts

VOLUME /opt/custom-tasks

ADD install_microkernel.sh /scripts/
ADD deploy_razor.sh /scripts/

RUN /scripts/install_microkernel.sh

EXPOSE    8080

RUN  chmod +x /start.sh
CMD  ["/start.sh"]
