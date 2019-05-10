#!/usr/bin/env bash

echo "checking for update: python pip"
python3 -m pip install --upgrade pip --quiet

echo "checking for update: admindojo"
python3 -m pip  install --upgrade admindojo --quiet
