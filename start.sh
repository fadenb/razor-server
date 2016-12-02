#!/bin/bash

mkernelurl=http://links.puppetlabs.com/razor-microkernel-latest.tar
mkerneltar=`basename $mkernelurl`
repodir=/var/lib/razor/repo-store


/etc/init.d/postgresql-9.2 start && \
     torquebox run --bind-address=0.0.0.0
