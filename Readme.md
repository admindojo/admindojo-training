<h1 align="center">
  <p align="center">admindojo.org</p>
  <a href="https://admindojo.org"><img height="300" src="https://admindojo.org/themes/admindojo/static/img/dojo_round.png" alt="admindojo"></a>
</h1>

# Introduction

admindojo is a free, interactive Linux tutorial for (junior) sysadmins.
Using local virtual machines, admindojo provides real-world scenarios in real environments.

This repository contains all trainings available.

Visit [admindojo.org](https://admindojo.org/getting-started) for more information.


# Basic Usage

1. Clone this repository
2. Change into cloned repo
2. Change to a training directory
    - e.g. `cd webserver-apache-basic-1-ub18`
3. Type `vagrant up`
    - Vagrant will now build the VM. The first run can take a while 
4. Type `vagrant ssh`
    - You're now inside the VM and can start the training
5. Run `admindojo` for instructions


# Bugs and Feedback

Feedback and bug reports are highly welcome!

Please create a [new issue at github](https://github.com/admindojo/admindojo-training/issues/new)

# Contributing

To create new trainings please see [admindojo\development\Readme.md](https://github.com/admindojo/admindojo-training/blob/master/admindojo/development/Readme.md)
