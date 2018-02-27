#!/bin/bash

if [ -z $1 ]
then
        echo "Need version as parameter"
	echo "Use: $0 version [release]"
        exit 1
fi

VERSION=$1
CURRENT_PWD=$(pwd)
NAME=ubuntu-font-family
SOURCES_DIR=~/rpmbuild/SOURCES
RELEASE=1

if [ ! -z $2 ]
then
        RELEASE=$2
fi

if [ ! -d $SOURCES_DIR ]
then
        mkdir -p $SOURCES_DIR
fi

cd $SOURCES_DIR

if [ ! -f $NAME-$VERSION.zip ]
then
	wget -c https://assets.ubuntu.com/v1/fad7939b-$NAME-$VERSION.zip
	mv fad7939b-$NAME-$VERSION.zip $NAME-$VERSION.zip
fi

cd $CURRENT_PWD

# Change version and release
cp  -f $NAME.spec $NAME-$VERSION.spec
sed -i "s/RPMVERSION/$VERSION/" $NAME-$VERSION.spec
sed -i "s/RPMRELEASE/$RELEASE/" $NAME-$VERSION.spec

rpmbuild -ba $NAME-$VERSION.spec

exit 0
