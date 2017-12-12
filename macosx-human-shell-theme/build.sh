#!/bin/bash 

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	VERSION=4.6.6
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
	wget -c 'https://dl.opendesktop.org/api/files/downloadfile/id/1510317957/s/1c8749259f272429ceb2ae99364ce801/t/1513099297/Human.zip'
	unzip Human.zip

	mv Human $NAME-$VERSION
	tar czvf $NAME-$VERSION.tgz $NAME-$VERSION
	# Clean
	rm Human.zip
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



