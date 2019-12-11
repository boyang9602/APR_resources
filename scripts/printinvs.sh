#!/bin/bash
for bid in *; do
	if [ ! -d $bid ]; then
		continue;
	fi
	cmd="cd $bid"
	echo $cmd
	eval $cmd
	for v in *; do
		if [ ! -d $v ]; then
			continue;
		fi
		cmd="cd $v"
		echo $cmd
		eval $cmd
		if [ -f invariants_files/chart.inv.gz ]; then
			mkdir -p /home/users/byang/Chart/pt_invs/$bid
			cmd="java -Xmx20G -cp $DAIKONDIR/daikon.jar daikon.PrintInvariants --output /home/users/byang/Chart/pt_invs/$bid/$v.inv.output invariants_files/chart.inv.gz"
			echo $cmd
			eval $cmd
		fi
		cd ..
	done
	cd ..
done
