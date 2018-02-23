#!/bin/bash

if [ -z $1 ]
then
        echo "Need version as parameter"
        exit 1
fi

if [ ! -z $2 ]
then
        RELEASE=$2
else
	RELEASE=1
fi

CURRENT_PWD=$(pwd)
RPM_URL=https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Workstation/source/tree/Packages/f/freetype-$1-$2.fc28.src.rpm
MY_RELEASE=$(($RELEASE +100))

rpm -ivh $RPM_URL
sed -i "s/Release:.*/Release: $MY_RELEASE%{?dist}/g" ~/rpmbuild/SPECS/freetype.spec
sed -i '/Release:.*/a Provides: freetype-freeworld' ~/rpmbuild/SPECS/freetype.spec
sed -i 's/%{!?_with_subpixel_rendering: %{!?_without_subpixel_rendering: %define _without_subpixel_rendering --without-subpixel_rendering}}/%{!?_with_subpixel_rendering: %{!?_without_subpixel_rendering: %define _with_subpixel_rendering --with-subpixel-rendering}}/' ~/rpmbuild/SPECS/freetype.spec

rpmbuild -ba ~/rpmbuild/SPECS/freetype.spec

exit 0

