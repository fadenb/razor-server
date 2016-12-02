#!/bin/bash
set -e
mkernelurl=http://links.puppetlabs.com/razor-microkernel-latest.tar
mkerneltar=`basename $mkernelurl`
repodir=/var/lib/razor/repo-store


cd $repodir
curl -LO $mkernelurl
tar xfva $mkerneltar
