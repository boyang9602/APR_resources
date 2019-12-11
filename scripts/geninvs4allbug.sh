#!/bin/bash
for bid in *; do
	if [ ! -d $bid ]; then
		continue;
	fi
	for v in $bid/*; do
		if [ ! -d $v ]; then
			continue
		fi
		cp gen4pinvs.sh $v
		cp gen4finvs.sh $v
		currpwd=$(pwd)
		cmd="cd $v"
		echo $cmd
		eval $cmd
		cmd="./gen4pinvs.sh ../passing_tests"
		echo $cmd
		eval $cmd
		cmd="./gen4finvs.sh"
		echo $cmd
		eval $cmd
		cd $currpwd
	done
done
