#!/bin/bash -ex

cd /tmp

mkdir build

mkdir build/m2

cd build

curl -L http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.tar.gz > apache-maven-3.3.1-bin.tar.gz

tar -xf apache-maven-3.3.1-bin.tar.gz

curl -L https://github.com/beabloo/james/archive/apache-james-3.0-beta3.tar.gz > james-project-source.tar.gz

tar -xf james-project-source.tar.gz

cd james-project-*

export MAVEN_OPTS="-Dmaven.repo.local=/tmp/build/m2"

/tmp/build/apache-maven-3.3.1/bin/mvn --batch-mode package -DskipTests -Pwith-assembly,with-jetm

if [ $? -eq 0 ]; then
   cp server/app/target/james-server-app-*-app.tar.gz /tmp
fi

cd /tmp

rm -rf build

tar xf james-server-app-*-app.tar.gz

rm -rf james-server-app-*-app.tar.gz

mv james-server-app*/* ${JAMES_HOME}

cd ${JAMES_HOME}

rm bin/wrapper-linux-x86-32

sed -i 's/wrapper.daemonize=TRUE/wrapper.daemonize=FALSE/' bin/james

# Fix default package cannot execute
for name in indexer quota events managesieveserver; do
    cp conf/${name}-template.xml conf/${name}.xml
done

rm -rf /tmp/*

rm $0

