#!/bin/bash
set -e
ln -s /opt/jboss/torquebox /opt/razor-torquebox
cd /opt/razor-server
echo 'Migrating database '
jruby bin/razor-admin -e production migrate-database
echo 'Deploying application'
torquebox deploy --env production
