#!/bin/bash 

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	VERSION=5.1.3.2
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
	wget -c 'https://dl.opendesktop.org/api/files/downloadfile/id/1513095868/s/fba9d1e65b55a584d83ccde742dfabdd/t/1513598737/Gnome-OSX-V-HSierra-1-3-2.tar.xz'
	unxz Gnome-OSX-V-HSierra-1-3-2.tar.xz
	tar xvf Gnome-OSX-V-HSierra-1-3-2.tar
	mv "Gnome-OSX-V-HSierra-1-3-2"  $NAME-$VERSION
	tar czvf $NAME-$VERSION.tgz $NAME-$VERSION
	# Clean
	rm Gnome-OSX-V-HSierra-1-3-2.tar
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



