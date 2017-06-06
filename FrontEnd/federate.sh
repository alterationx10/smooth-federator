#!/bin/bash

# It doesn't seem like you can set up federation via config file
# https://github.com/rabbitmq/rabbitmq-server/issues/1168

# Set monitor mode so we can put rabbitmq-server into the background,
# and then pull it to fg to leave a running process for docker.
set -m

# This seems to be the default, but set it as a variable so there's no surprise change
# down the road
export RABBITMQ_PID_FILE=/var/lib/rabbitmq/mnesia/rabbit@${HOSTNAME}.pid

# Call the stock docker-entrypoint script with rabbitmq-server, as originally intended, 
# but also put it in the background
docker-entrypoint.sh rabbitmq-server &

# Wait for the rabbitmq-server to come up, so we can issue some commands
# to automatically federate
rabbitmqctl wait ${RABBITMQ_PID_FILE}
rabbitmqctl set_parameter federation-upstream upstream '{"uri":"amqp://upstream","expires":3600000}'
rabbitmqctl set_policy --apply-to exchanges federated "^amq\." '{"federation-upstream-set":"all"}'
rabbitmqctl set_policy --apply-to queues federated "^lala\." '{"federation-upstream-set":"all"}'

# Bring rabbitmq-server back to the foreground as a running process, so docker doesn't exit immediately.
fg
