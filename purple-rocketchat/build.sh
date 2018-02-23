#!/bin/bash -x

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	RELEASE=1
else
	RELEASE=$1
fi

rpm -qi mercurial > /dev/null

if [ $? -ne 0 ]
then
	echo "Please install mercurial first"
	exit 1
fi

VERSION=`hg id -i https://bitbucket.org/EionRobb/$NAME/`

if [ ! -f $NAME-$VERSION.tgz ]
then
	hg clone https://bitbucket.org/EionRobb/$NAME/
	mv  $NAME $NAME-$VERSION
	tar --exclude='.hg*' czvf $NAME-$VERSION.tgz $NAME-$VERSION
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



