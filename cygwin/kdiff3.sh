#!/bin/sh
RESULT=""
for arg
do
    if [[ "" != "$arg" ]] && [[ -e $arg ]];
    then
        OUT=`cygpath -wa $arg`
    else
        OUT=$arg
        if [[ $arg == -* ]];
        then
            OUT=$arg
        else
            OUT="'$arg'"
        fi
    fi
    RESULT=$RESULT" "$OUT
done
/cygdrive/c/Program\ Files/KDiff3/kdiff3.exe $RESULT
