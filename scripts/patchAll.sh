#!/bin/bash
patchesLoc=~/projects/DefectRepairing/tool/patches

root=$(pwd)
for bug_id in *; do
    cmd="cd ${root}"
    echo $cmd
    eval $cmd
    if [ ! -d $bug_id ]; then
        continue;
    fi
    cmd="cd $root/$bug_id/patches/"
    echo $cmd
    eval $cmd
    for patch in *; do
        cmd="cd $root/$bug_id/patches/$patch"
        echo $cmd
        eval $cmd
        patchFile=$patchesLoc/$patch
        bugFile=$(head -n 1 $patchFile | sed 's/diff .* Chart[[:digit:]]\+b\/\(.*\.java\) .*.java/\1/')
        cmd="patch $bugFile $patchFile"
        echo $cmd
        eval $cmd
    done
done