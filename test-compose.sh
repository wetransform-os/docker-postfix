#!/bin/bash

#
# Small script using telnet to send a test mail
# to the docker-compose setup (assumes localhost
# as docker host where the port is mapped to)
#

auth=$( echo -ne '\0user\0pwd' | openssl enc -base64 )

{ echo "ehlo test";
  sleep 1;
  echo "auth plain $auth";
  sleep 1;
  echo "mail from: root@localhost";
  sleep 1;
  echo "rcpt to: admin@localdomain";
  sleep 1;
  echo "data"
  sleep 1;
  echo "Hi there,
this is a test.
.";
  sleep 1;
  echo "quit";
} | telnet localhost 1025
