# s2i-clojure
FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

MAINTAINER Huub Daems <buuhsmead@gmail.com>

ENV BUILDER_VERSION 1.1.0

LABEL io.k8s.description="Platform for building Clojure apps" \
      io.k8s.display-name="Clojure s2i 1.1.0" \
      io.openshift.expose-services="3000:http,8778:nrepl" \
      io.openshift.tags="builder,clojure,lein,leiningen"


RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ${HOME}/lein
RUN chmod 775 ${HOME}/lein
RUN ${HOME}/lein

COPY ./s2i/bin/ /usr/local/s2i

# RUN chmod 775 ${HOME}

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root



# This default user is created in the openshift/base-centos7 image
#USER 1001



EXPOSE 8080 8778

CMD ["/usr/libexec/s2i/usage"]
