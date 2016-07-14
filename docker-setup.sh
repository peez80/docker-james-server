#!/bin/bash -ex

cd /tmp

mkdir build

mkdir build/m2

cd build

curl -L http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz > apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz

curl -L http://archive.apache.org/dist/james/apache-james/3.0beta3/apache-james-3.0-beta3-app.tar.gz > /tmp/apache-james-3.0-beta3-app.tar.gz

cd /tmp

rm -rf build

tar xf apache-james-*-app.tar.gz

rm -rf apache-james-*-app.tar.gz

mv apache-james-*/* ${JAMES_HOME}

cd ${JAMES_HOME}

rm bin/wrapper-linux-x86-32

sed -i 's/wrapper.daemonize=TRUE/wrapper.daemonize=FALSE/' bin/james

# Fix default package cannot execute
# for name in indexer quota events managesieveserver; do
#     cp conf/${name}-template.xml conf/${name}.xml
# done

rm -rf /tmp/*

rm $0

