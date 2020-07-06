#!/bin/bash
if [ $# != "1" ]
then
    echo "Usage: utils/releasetools/02_upload_tarball.sh <version>"
    exit 1
fi

echo "Uploading..."
scp /tmp/redis-${1}.tar.gz redis.io:/var/virtual/download.redis.io/httpdocs/releases/
echo "Updating web site... (press any key if it is a stable release, or Ctrl+C)"
read x
ssh redis.io "cd /var/virtual/download.redis.io/httpdocs; 
              rm -rf redis-${1}.tar.gz
              wget http://download.redis.io/releases/redis-${1}.tar.gz
              tar xvzf redis-${1}.tar.gz
              rm -rf redis-stable
              mv redis-${1} redis-stable
              tar cvzf redis-stable.tar.gz redis-stable
              rm -rf redis-${1}.tar.gz
              cp _htaccess redis-stable/.htaccess"
