#!/bin/bash
set -e
mkernelurl=http://links.puppetlabs.com/razor-microkernel-latest.tar
mkerneltar=`basename $mkernelurl`
repodir=/var/lib/razor/repo-store


if [[ ! -e /opt/razor-torquebox ]]; then
  echo "Setting up config file for ${DATABASE_USERNAME}@${DATABASE_HOSTNAME} w/password"
  sed -ri "s/DBHOSTNAME/${DATABASE_HOSTNAME}/" /opt/razor-server/config.yaml
  sed -ri "s/PGUSERNAME/${DATABASE_USERNAME}/" /opt/razor-server/config.yaml
  sed -ri "s/PGPASSWORD/${DATABASE_PASSWORD}/" /opt/razor-server/config.yaml

  echo "Deploying application"
  /scripts/deploy_razor.sh
  touch /initialised
  echo "Application deployed"
fi

echo "Starting..."
torquebox run --bind-address=0.0.0.0
