
# s2i-clojure
##FROM openshift/base-centos7
##FROM openshift/redhat-openjdk18-openshift
FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

# TODO: Put the maintainer name in the image metadata
# MAINTAINER Your Name <your@email.com>
MAINTAINER Huub Daems <buuhsmead@gmail.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building Clojure apps" \
      io.k8s.display-name="Clojure s2i 0.1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,clojure"


# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
##RUN yum install -y rubygems && yum clean all -y
##RUN gem install asdf

# TODO: do not like this. needs to be in upper level Docker image
##RUN yum -y install java-1.8.0-openjdk-devel && yum clean all

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ${HOME}/lein
RUN chmod 775 ${HOME}/lein
RUN ${HOME}/lein

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
###COPY ./s2i/bin/ /usr/libexec/s2i
COPY ./s2i/bin/ /usr/local/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
##USER 1001
# This is the default jboss user
#USER 185


# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
