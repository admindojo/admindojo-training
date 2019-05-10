#!/usr/bin/env bash

TOKEN=""

TOKEN1=$(curl localhost --silent | md5sum | awk '{print $1}')
TOKEN2=$(curl -k https://localhost --silent | md5sum | awk '{print $1}')
TOKEN3=$(curl -I --silent  http://localhost  | grep Server | cut -d/ -f1 | md5sum | awk '{print $1}')
TOKEN=$(echo -n $TOKEN1 $TOKEN2 $TOKEN3 | md5sum | awk '{print $1}')
echo ${TOKEN}