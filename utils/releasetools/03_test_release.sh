#!/bin/sh
if [ $# != "1" ]
then
    echo "Usage: utils/releasetools/03_test_release.sh <version>"
    exit 1
fi

TAG=$1
TARNAME="redis-${TAG}.tar.gz"
DOWNLOADURL="http://download.redis.io/releases/${TARNAME}"

ssh ci.redis.io   "export TERM=xterm;
                   cd /tmp;
                   rm -rf test_release_tmp_dir;
                   cd test_release_tmp_dir;
                   rm -f $TARNAME;
                   rm -rf redis-${TAG};
                   wget $DOWNLOADURL;
                   tar xvzf $TARNAME;
                   cd redis-${TAG};
                   make;
                   ./runtest;
                   ./runtest-sentinel;
                   ./runtest-cluster;
                   ./runtest-moduleapi;

