#!/usr/bin/env bash

function operator {
#!/bin/bash
# boy, is this ugly ...
chat -t 1 -e "" '\pAT' OK AT+COPS? +COPS '\pAT' OK >> /dev/ttyUSB1 < /dev/ttyUSB1 2>/tmp/foo
grep -m 1 '^+COPS' /tmp/foo
}

while [ -e /dev/ttyUSB0 ] ; do
  # wait to be registered
  if operator | grep -q ','; then
    wvdial provider >> wvdial.log 2>&1
  fi
  sleep 1
done

