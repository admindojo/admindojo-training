#!/usr/bin/env bash

TOKEN=""
# a token should be a md5 hash but could be any string.
# ideally use 2-4 single hashes and generate a new hash over all tokens
# don't use fancy commands, they should work on all distributions
# only generate hashes of files and commands that never change
# example:
TOKEN1=$(curl localhost --silent | md5sum | awk '{print $1}')
TOKEN2=$(curl -k https://localhost --silent | md5sum | awk '{print $1}')
TOKEN3=$(curl -I --silent  http://localhost  | grep Server | cut -d/ -f1 | md5sum | awk '{print $1}')
TOKEN=$(echo -n $TOKEN1 $TOKEN2 $TOKEN3 | md5sum | awk '{print $1}')

# Script MUST output ONE string
echo ${TOKEN}