FROM rabbitmq:management-alpine
# Should be in the upstream image soon :-)
RUN apk --no-cache add procps
RUN rabbitmq-plugins enable --offline rabbitmq_federation
RUN rabbitmq-plugins enable --offline rabbitmq_federation_management
# This should be here from the rabbitmq upstream, 
# but we want to run our script instead.
COPY federate.sh /usr/local/bin/
ENTRYPOINT ["federate.sh"]
