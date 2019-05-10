#!/usr/bin/env bash

TOKEN=""

TOKEN=$(df --output=source,fstype,target /data | md5sum | awk '{print $1}')
echo ${TOKEN}