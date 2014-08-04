Introduction
============
This project contains the definitions for the computing environments
to be used for the SKA pulsar group at Oxford.

We use "puppet" to configure and setup of the platforms.
Puppet allows you to define a system configuration. 
It will then check to see if the machine is in the required state 
and if not it will run suitable commands to achieve it.
There is a certain element of abstraction making porting to
different platforms easier.

For virtual machine management we use vagrant. 
Vagrant will provide a local copy of a vm and then uses puppet to 
provision it as required.

Setting up
==========
Once you have cloned this repository to your local area you wll need to
initialise the submdoules with the following commands:

git submodule init
git submodule update

Your current machine must have the vagrant package installed and virtual box.
(You can use other virtual machine software than virtualbox, but you will have 
to provide your own base image).

Getting a Virtual Machine up and runing With vagrant
====================================================

Once installed you can set up a vm with:

vagrant up <machine_name>

(run from the top level directory of this project)

Now you should have a running vm. You can ssh in to it:

vagrant ssh <machine_name>


Machines Available
==================

Name        : artemis
Description : An artemis development machine with all dependencies installed

Name        : pulsar_analysis
Description : A workstation with all the common pulsar analysis tools installed
