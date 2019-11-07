#!/bin/bash 

NAME=$(basename `pwd`)

if [ -z "$1" ]
then
	VERSION=1.0.0
else
	VERSION=$1
fi

if [ -z "$2"]
then
	RELEASE=1
else
	RELEASE=$2
fi

# Clean old runs
echo "Clean workspace..."
rm -rf $NAME-$VERSION

# Install required tools
echo "Installing required tools..."
sudo dnf install wget xz tar ImageMagick rpm-build -y

echo "Getting Mojave Wallpapers..."
mkdir -p $NAME-$VERSION
cd $NAME-$VERSION
wget -c https://media.idownloadblog.com/wp-content/uploads/2018/06/macOS-Mojave-Day-wallpaper.jpg
wget -c https://media.idownloadblog.com/wp-content/uploads/2018/06/macOS-Mojave-Night-wallpaper.jpg

echo "Convert orginal images to png format..."
convert macOS-Mojave-Day-wallpaper.jpg mojave-day.png
convert macOS-Mojave-Night-wallpaper.jpg mojave-night.png

echo "Resizing images from 5120x2880 to 1920x1080..."
mkdir -p tv-wide
convert -resize 1920x1080 mojave-day.png tv-wide/mojave-day.png 
convert -resize 1920x1080 mojave-night.png tv-wide/mojave-night.png

echo "Resizing images from 5120x2880 to 1920x1200..."
mkdir -p wide
convert -resize 1920x1200 mojave-day.png wide/mojave-day.png 
convert -resize 1920x1200 mojave-night.png wide/mojave-night.png

echo "Resizing images from 5120x2880 to 2048x1536..."
mkdir -p standard
convert -resize 2048x1536 mojave-day.png standard/mojave-day.png 
convert -resize 2048x1536 mojave-night.png standard/mojave-night.png

echo "Resizing images from 5120x2880 to 1280x1024..."
mkdir -p normalish
convert -resize 1280x1024 mojave-day.png normalish/mojave-day.png 
convert -resize 1280x1024 mojave-night.png normalish/mojave-night.png

echo "Cleaning original images..."
rm -f macOS-Mojave-Day-wallpaper.jpg macOS-Mojave-Night-wallpaper.jpg mojave-day.png mojave-night.png
cd ..

echo "Generating src file to build rpm..."
tar czvf $NAME-$VERSION.tgz $NAME-$VERSION

if ! [ -d ~/rpmbuild/SOURCES ]
then
	mkdir -p ~/rpmbuild/SOURCES
fi

cp -f $NAME-$VERSION.tgz ~/rpmbuild/SOURCES/
cp -f *.xml ~/rpmbuild/SOURCES/

# Change version and release
cp  -f $NAME.spec $NAME-$VERSION.spec
sed -i "s/RPMVERSION/$VERSION/" $NAME-$VERSION.spec
sed -i "s/RPMRELEASE/$RELEASE/" $NAME-$VERSION.spec
sed -i "s/RPMNAME/$NAME/" $NAME-$VERSION.spec

rpmbuild -ba $NAME-$VERSION.spec

exit 0
