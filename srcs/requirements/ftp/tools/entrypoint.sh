#!/bin/sh
set -e

echo "Starting FTP server..."

echo "user:password" | chpasswd


mkdir -p /home/ftp/user/files
mkdir -p /var/run/vsftpd/empty


chown -R user:user /home/ftp/user
chmod 755 /home/ftp/user
chmod 755 /home/ftp/user/files

echo "FTP Server is ready"


exec vsftpd /etc/vsftpd/vsftpd.conf