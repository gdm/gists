#!/bin/bash
#===============================================================================
#
#          FILE:  convert.sh
# 
#         USAGE:  ./convert.sh 
# 
#   DESCRIPTION:  convert mp4 to mp3
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Dmytro Gorbunov
#       VERSION:  1.0
#       CREATED:  03/15/2017 01:10:21 CET
#      REVISION:  ---
#===============================================================================

extra_opt="-aid 0"
filetype=mp4

for file in *$filetype ; do
        basename=`basename "$file" ".$filetype"`
        mplayer $extra_opt -vc dummy -vo null -ao pcm:file="$basename.wav",fast "$file"
        lame -h -b128 "$basename.wav" "$basename.mp3"
        rm -v "$basename.wav"
done