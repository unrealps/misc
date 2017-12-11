#!/bin/bash 

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	VERSION=1.0.2
else
	VERSION=$1
fi

if [ -z "$2"]
then
	RELEASE=1
else
	RELEASE=$2
fi


# Install convert 5K to FullHD
sudo dnf install ImageMagick
rm -rf $NAME-$VERSION
mkdir $NAME-$VERSION

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-0_10.1.png'
convert '10-0_10.1.png' -resize '1920x1080' -quality 100 -format "png" $NAME-$VERSION/Cheetah_Puma.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-2.png'
convert '10-2.png' -resize '1920x1080' -quality 100 -format "png" $NAME-$VERSION/Jaguar.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-3.png'
convert 10-3.png -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Panther.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-4.png'
convert '10-4.png' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Tiger.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-5.png'
convert '10-5.png' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Leopard.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-6.png'
convert '10-6.png' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/SnowLeopard.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-7.png'
convert '10-7.png' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Lion.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-8.jpg'
convert '10-8.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/MountainLion.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-9.jpg'
convert '10-9.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Mavericks.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-10.jpg'
convert '10-10.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Yosemite.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-11.jpg'
convert '10-11.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/ElCapitan.png

wget -c --show-progress 'http://512pixels.net/downloads/macos-wallpapers/10-12.jpg'
convert '10-12.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/Sierra.png

wget -c --show-progress 'https://512pixels.net/downloads/macos-wallpapers/10-13.jpg'
convert '10-13.jpg' -resize "1920x1080" -quality 100 -format "png" $NAME-$VERSION/HighSierra.png

tar czvf $NAME-$VERSION.tgz $NAME-$VERSION

if ! [ -d ~/rpmbuild/SOURCES ]
then
	mkdir ~/rpmbuild/SOURCES
fi

cp -f $NAME-$VERSION.tgz ~/rpmbuild/SOURCES/
cp -f $NAME.xml ~/rpmbuild/SOURCES/

# Change version and release
cp  -f $NAME.spec $NAME-$VERSION.spec
sed -i "s/RPMVERSION/$VERSION/" $NAME-$VERSION.spec
sed -i "s/RPMRELEASE/$RELEASE/" $NAME-$VERSION.spec
sed -i "s/RPMNAME/$NAME/" $NAME-$VERSION.spec

rpmbuild -ba $NAME-$VERSION.spec

exit 0



