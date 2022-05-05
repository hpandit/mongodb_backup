#!/bin/sh

if [[ $# -ne 2 ]] ; then
    echo 'Arguments are missing (mongouri, S3bucket path)'
    exit 1
fi

echo "removing existing dump folder"
rm -Rf /home/mongodump

echo "creating dump folder"
mkdir -p /home/mongodump && cd /home/mongodump

echo "Running mongodump command"
mongodump --uri=$1

echo "Compresing mongod dump"
backup_date=$(date +'%m-%d-%Y_%I-%M-%S_%p_%Z')
backup_date="mongodump-${backup_date}.tar.gz"

echo "Backup file name $backup_date"
tar cvfz $backup_date dump/

echo "Pushing to S3 bucket"
aws s3 --region us-east-1 cp $backup_date $2

echo "Removing local backup folders"
rm -Rf dump $backup_date

echo "Done."
