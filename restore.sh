#!/bin/bash

# GCS bucket name
GCS_BUCKET="jenkins_server_backup"

# Directory to restore the backup
RESTORE_DIR="/tmp/jenkins_restore"

# Create a directory to store the downloaded backup files
mkdir -p $RESTORE_DIR

# Download backup files from GCS
gsutil cp gs://$GCS_BUCKET/backups/jenkins_backup_{timestamp}.tar.gz $RESTORE_DIR/


# Extract backup files to Jenkins home directory
sudo tar -zxvf $RESTORE_DIR/enkins_backup_{timestamp}.tar.gz -C /


# Cleanup downloaded backup files
sudo rm -rf $RESTORE_DIR
