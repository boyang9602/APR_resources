#!/bin/bash

outputInvs() {
	cmd="cd $1"
	echo $cmd
	eval $cmd
	for invsGz in *.inv.gz; do
		cmd="java -Xmx4096M -cp /home/bo/projects/daikon-5.7.2/daikon.jar daikon.PrintInvariants ${invsGz} --output ${invsGz}.output --ppt-select-pattern org\.jfree.*"
		echo "$cmd"
		eval "$cmd"
	done
}

root=$(pwd)
for bug_id in *; do
	cmd="cd $root"
	echo $cmd
	eval $cmd
	if [[ ! -d $bug_id ]]; then
		continue
	fi
	cmd="cd $bug_id"
	echo $cmd
	eval $cmd
	outputInvs $root/$bug_id/b/
	outputInvs $root/$bug_id/f/
	cmd="cd $root/$bug_id/patches"
	echo $cmd
	eval $cmd
	for patch in *; do
		outputInvs $root/$bug_id/patches/$patch/
	done
done