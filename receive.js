#!/usr/bin/env node

// You'll have to open the ports on web: (and only scale 1) to test this out!

var amqp = require('amqplib/callback_api');

amqp.connect('amqp://localhost:5673', function(err, conn) {
  conn.createChannel(function(err, ch) {
    var q = 'lala.lo';

    ch.assertQueue(q, {durable: false});
    console.log(" [*] Waiting for messages in %s. To exit press CTRL+C", q);
    ch.consume(q, function(msg) {
      console.log(" [x] Received %s", msg.content.toString());
    }, {noAck: true});
  });
});
