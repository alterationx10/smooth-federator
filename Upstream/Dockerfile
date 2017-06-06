FROM rabbitmq:management-alpine
RUN rabbitmq-plugins enable --offline rabbitmq_federation
RUN rabbitmq-plugins enable --offline rabbitmq_federation_management
ADD erlang.cookie /var/lib/rabbitmq/erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/erlang.cookie
RUN chmod 600 /var/lib/rabbitmq/erlang.cookie
