#!/bin/sh
set -e

echo "Starting FTP server..."

# Set password
echo "user:password" | chpasswd

# Ensure directories exist
mkdir -p /home/ftp/user/files
mkdir -p /var/run/vsftpd/empty

# Set permissions
chown -R user:user /home/ftp/user
chmod 755 /home/ftp/user
chmod 755 /home/ftp/user/files

echo "FTP Server is ready"

# Start vsftpd in foreground
exec vsftpd /etc/vsftpd/vsftpd.conf