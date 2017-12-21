#!/bin/bash 

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	VERSION=2.1
else
	VERSION=$1
fi

if [ -z "$2"]
then
	RELEASE=1
else
	RELEASE=$2
fi

if [ ! -f $NAME-$VERSION.tgz ]
then
	wget -c 'https://dl.opendesktop.org/api/files/downloadfile/id/1501620933/s/7e5cad9f71d8add912958ded6344bf6f/t/1513871143/capitaine-cursors-r2.1.tar.gz'
	tar xzvf capitaine-cursors-r2.1.tar.gz

	mv capitaine-cursors $NAME-$VERSION
	tar czvf $NAME-$VERSION.tgz $NAME-$VERSION
	# Clean
	rm -f capitaine-cursors-r2.1.tar.gz
	rm -rf $NAME-$VERSION
fi

if ! [ -d ~/rpmbuild/SOURCES ]
then
	mkdir ~/rpmbuild/SOURCES
fi

cp -f $NAME-$VERSION.tgz ~/rpmbuild/SOURCES/

# Change version and release
cp  -f $NAME.spec $NAME-$VERSION.spec
sed -i "s/RPMVERSION/$VERSION/" $NAME-$VERSION.spec
sed -i "s/RPMRELEASE/$RELEASE/" $NAME-$VERSION.spec
sed -i "s/RPMNAME/$NAME/" $NAME-$VERSION.spec

rpmbuild -ba $NAME-$VERSION.spec

exit 0



