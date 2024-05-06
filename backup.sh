#!/bin/bash

# Jenkins Home directory
JENKINS_HOME="/var/lib/jenkins"

# Backup directory
BACKUP_DIR="/mnt/backup"

# GCS bucket name
GCS_BUCKET="jenkins_server_backup"

# Create a timestamp for the backup file name
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a backup directory if it doesn't exist
sudo mkdir -p $BACKUP_DIR

# Backup Jenkins  files
sudo tar -zcvf $BACKUP_DIR/jenkins_backup_$TIMESTAMP.tar.gz $JENKINS_HOME/

# Upload backups to GCS
gsutil cp $BACKUP_DIR/jenkins_backup_$TIMESTAMP.tar.gz gs://$GCS_BUCKET/backups/

# Cleanup local backups
sudo rm $BACKUP_DIR/*.tar.gz

#Optionally, you can cleanup old backups in GCS as well
# gsutil rm gs://$GCS_BUCKET/backups/jenkins_*.tar.gz