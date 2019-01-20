#!/bin/bash
service mongodb start
cd /opt/wiki.js
config=$(grep 'http://localhost' config.yml)
if [ -z "$config" ]
then
    echo "$config so start"
    sleep 5
    node wiki start
else
    echo "$config so configure"
    sleep 5
    node wiki configure
fi