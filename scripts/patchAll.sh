#!/bin/bash
patchesLoc=~/DefectRepairing/tool/patches

root=$(pwd)
for bug_id in *; do
    cmd="cd ${root}"
    echo $cmd
    eval $cmd
    if [ ! -d $bug_id ]; then
        continue;
    fi
    cmd="cd $bug_id"
    echo $cmd
    eval $cmd
    for patch in *_Patch*; do
        arr=(${patch//_/ })
        cmd="cd $patch"
        echo $cmd
        eval $cmd
        patchFile=$patchesLoc/${arr[1]}
        cmd="patch -i $patchFile -p 1"
        echo $cmd
        eval $cmd
        cmd="cd $root/$bug_id"
        echo $cmd
        eval $cmd
    done
done