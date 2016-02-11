FROM radial/busyboxplus:curl
MAINTAINER Michal Fojtik <mi@mifo.sk>

LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i
ENV RELEASE_URL=https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz

RUN mkdir -p /opt/app-root/src/static /opt/app-root/bin && \
    cd /opt/app-root/bin && \
    curl -L $RELEASE_URL | gzip -d | tar xf - && \
    ln -sf hugo_0.15_linux_amd64/hugo_0.15_linux_amd64 hugo && \
    chmod -R og+rwx /opt/app-root && \
    chown -R 1001:0 /opt/app-root

ENV PATH=$PATH:/opt/app-root/bin
WORKDIR /opt/app-root/src
EXPOSE 8080
ADD ./s2i/* /usr/libexec/s2i/
USER 1001
