#!/bin/bash
set -e
puppet apply /razor-postgres-install.pp
cd /opt/razor
# cp config.yaml.sample config.yaml
sed -i 's/razor_prd/razor/' /etc/razor/config.yaml
jruby bin/razor-admin -e production migrate-database
torquebox deploy --env production
