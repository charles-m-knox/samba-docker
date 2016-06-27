#!/bin/bash
docker run -d \
  --name samba \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -p 445:445/udp \
  --hostname 'black-pearl' \
  -v /media/stick:/share/stick \
  dastrasmue/rpi-samba \
  -u "daniel:daniel" \
  -s "test:/share/stick:ro:"
