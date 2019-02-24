#!/usr/bin/env bash
find /vagrant/training/ -name "*.sh" -exec sudo bash {} \;
inspec exec /vagrant/training/ --reporter cli