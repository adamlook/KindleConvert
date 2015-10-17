#!/bin/sh

if [ -z "$1" ] ; then
cat <<EOF
*************************************************************
 kindleconvert [https://github.com/adamlook/KinldeConvert]
 based on below tools:
 KindleUnpack V0.80 from https://github.com/kevinhendricks/KindleUnpack.git
 Amazon kindlegen(MAC OSX) V2.9 build 1028-0897292 
*************************************************************
Usage : kindleconvert [filename.azw3 or direcotry] [-append_source]

Note:
https://github.com/adamlook/KinldeConvert    
EOF
exit 1
fi

inputfile="$1"
inputpath=`dirname "$inputfile"`
inputfile=`basename "$inputfile"`

if [ "$inputpath" = "." ] ; then
    inputpath=`pwd`
fi
full_filename="$inputpath"/"$inputfile"

if [ ! -f "$full_filename" ] ; then
    echo "File does not exist!"
    echo "Please confirm the filename or the directory."
else
    echo "*************************************************************"
    echo "               STARTING UNPACK AZW3 FILE"
    echo "*************************************************************"
    filename=`basename "$full_filename" | sed 's:\..*::'`
    epubfolder=~/Desktop/kindleconvert/"$filename"
    epubfile="$epubfolder"/mobi8/"$filename".epub
    mkdir -p "$epubfolder"
    pyscript=$(cd "$(dirname "$0")"; pwd)
    pyscript="$pyscript"/KindleUnpack/lib/kindleunpack.py
    python "$pyscript" "$full_filename" "$epubfolder"

fi


if [ -f "$epubfile" ] ; then
    echo "*************************************************************"
    echo "           STARTING CONVERT TO MOBI FILE"
    echo "*************************************************************"
    mobifile=`/home/"$username"/kindleconvert/"$filename"/filename.mobi`
    kendlegen=$(cd "$(dirname "$0")"; pwd)
    kindlegen="$kindlegen"/KindleGen_Mac_i386_v2_9/kindlegen
    kindlegen -dont_append_source "$epubfile" -o "$mobifile"
fi
