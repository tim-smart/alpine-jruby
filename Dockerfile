FROM develar/java:latest

ENV JRUBY_VERSION="9.0.4.0" \
    PATH="/opt/jruby/bin:$PATH"

RUN echo 'http://alpine.gliderlabs.com/alpine/v3.2/main' > /etc/apk/repositories && \
    echo 'http://alpine.gliderlabs.com/alpine/edge/community' >> /etc/apk/repositories && \
    PACKAGES="ca-certificates bash" && \
    BUILD_PACKAGES="wget" && \
# packages
    apk add --update $PACKAGES $BUILD_PACKAGES && \
# download
    cd /tmp && \
    wget "https://s3.amazonaws.com/jruby.org/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz" && \
# extract and move
    tar -xzvf jruby-bin-$JRUBY_VERSION.tar.gz -C /tmp && \
    mkdir -p /opt && \
    mv /tmp/jruby-$JRUBY_VERSION /opt/jruby && \
# symlink ruby
    ln -s /opt/jruby/bin/jruby /usr/local/bin/ruby && \
# clean up
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/* /tmp/*
