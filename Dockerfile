# s2i-clojure
FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
MAINTAINER Huub Daems <buuhsmead@gmail.com>

ENV BUILDER_VERSION 1.0.0

LABEL io.k8s.description="Platform for building Clojure apps" \
      io.k8s.display-name="Clojure s2i 1.0.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,clojure"


RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ${HOME}/lein
RUN chmod 775 ${HOME}/lein
RUN ${HOME}/lein

COPY ./s2i/bin/ /usr/local/s2i

RUN chmod 775 ${HOME}

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
