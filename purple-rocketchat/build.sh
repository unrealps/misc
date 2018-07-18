#!/bin/bash -x

NAME=$(basename `pwd`)

rpm -qi mercurial > /dev/null

if [ $? -ne 0 ]
then
	echo "Please install mercurial first"
	exit 1
fi

if [ -f "$NAME" ]
then
	rm -rf $NAME
fi

hg clone https://bitbucket.org/EionRobb/$NAME/
cd $NAME
REVISION_ID=$(hg id -i)
REVISION_NUMBER=$(hg id -n)
VERSION=0.9.$(date +%Y.%m.%d).git.r$REVISION_NUMBER.$REVISION_ID
RELEASE=1
cd ..

if [ -f "$NAME-$VERSION.tgz" ]
then
	rm -f $NAME-$VERSION.tgz
fi

if [ -d "$NAME-$VERSION" ]
then
	rm -rf $NAME-$VERSION
fi

mv  $NAME $NAME-$VERSION
#tar --exclude='.hg*' -czvf $NAME-$VERSION.tgz $NAME-$VERSION
tar -czvf $NAME-$VERSION.tgz $NAME-$VERSION

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



