#!/bin/bash
ip route del default
ip ro add default via 172.30.201.1
supervisord -n -c /root/.cuckoo/supervisord.conf
