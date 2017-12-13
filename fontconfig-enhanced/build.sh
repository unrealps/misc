#!/bin/bash

NAME=$(basename `pwd`)
SOURCES_DIR=~/rpmbuild/SOURCES

if [ ! -d $SOURCES_DIR ]
then
        mkdir -p $SOURCES_DIR
fi

rpmbuild -ba $NAME.spec

exit 0
