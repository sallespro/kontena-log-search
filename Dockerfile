FROM fluent/fluentd:latest

USER root
RUN apk --no-cache --update add \
                            build-base \
                            ruby-dev && \
    gem install bson_ext fluent-plugin-mongo fluent-plugin-s3 fluent-plugin-elasticsearch && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
USER fluent
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.2.0/bin:$PATH
#ADD fluentd.conf /fluentd/etc/fluentd.conf
ADD fluentd-stdout.conf /fluentd/etc/fluentd-stdout.conf
CMD fluentd -c /fluentd/etc/fluentd.conf $FLUENTD_OPT
