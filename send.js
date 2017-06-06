#!/usr/bin/env node

var amqp = require('amqplib/callback_api');

amqp.connect('amqp://localhost', function(err, conn) {
  conn.createChannel(function(err, ch) {
    var q = 'lala.lo';

    ch.assertQueue(q, {durable: false});
    // Note: on Node 6 Buffer.from(msg) should be used
    for ( var i = 0; i < 10; i++) {
    var msg = 'Hello ' + i;
      ch.sendToQueue(q, new Buffer(msg));
      console.log(" [x] Sent %s", msg);
    }
  });
  setTimeout(function() { conn.close(); process.exit(0) }, 500);
});
