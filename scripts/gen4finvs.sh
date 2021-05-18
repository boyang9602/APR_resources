#!/bin/bash
defects4j compile

test_cases=""
raw=$(tail -n 1 defects4j.build.properties | sed 's/d4j\.tests\.trigger=\(.*\)/\1/')
IFS=',' read -ra tcarr <<< $raw
for tc in ${tcarr[@]}; do
        test_cases="$test_cases$tc "
done
CLASSPATH=$(find "$PWD" -name '*.jar' -type f -printf ':%p\n' | sort -u | tr -d '\n')
project=$(tail -n2 defects4j.build.properties | head -n1 | sed 's/d4j\.project\.id=\(.*\)/\1/')
if [[ $project = Chart ]]; then
	path="$DAIKONDIR/daikon.jar:build/:build-tests/$CLASSPATH:/home/ubuntu/launcher/"
elif [[ $project = Math ]]; then
	path="$DAIKONDIR/daikon.jar:target/classes/:target/test-classes/$CLASSPATH:/home/ubuntu/launcher/"
elif [[ $project = Time ]]; then
	path="$DAIKONDIR/daikon.jar:target/classes/:target/test-classes/:build/classes/:build/tests/$CLASSPATH:/home/ubuntu/launcher/"
elif [[ $project = Lang ]]; then
	path="$DAIKONDIR/daikon.jar:target/classes/:target/test-classes/:target/tests/$CLASSPATH:/home/ubuntu/launcher/"
elif [[ $project = Mockito ]]; then
	path="$DAIKONDIR/daikon.jar:target/classes/:target/test-classes/$CLASSPATH:/home/ubuntu/launcher/"
elif [[ $project = Closure ]]; then
	path="$DAIKONDIR/daikon.jar:build/classes/:build/test/$CLASSPATH:/home/ubuntu/launcher/"
fi

a=0
while read classes ; do
	IFS=',' read -ra classArr <<< "$classes"
	pptpattern=""
	for class in "${classArr[@]}"; do
		pptpattern="'--ppt-select-pattern=^${class//\./\\\.}' $pptpattern"
	done

	folder=ft_invariants_files$a
	if [[ -d $folder ]]; then
		rm -rf $folder
	fi
	mkdir $folder
	cmd="java -Xmx43G -cp $path daikon.DynComp $pptpattern --output-dir=$folder TestRunner $test_cases |& tee $folder/dyncomp-output.txt"
	echo $cmd
	echo $cmd >> $folder/cmds.txt
	eval $cmd
	cmd="java -Xmx43G -cp $path daikon.Chicory $pptpattern --heap-size=43G --comparability-file=$folder/TestRunner.decls-DynComp --output-dir=$folder TestRunner $test_cases |& tee $folder/chicory-output.txt"
	echo $cmd
	echo $cmd >> $folder/cmds.txt
	eval $cmd
	cmd="java -Xmx43G -cp $DAIKONDIR/daikon.jar daikon.Daikon -o $folder/closure.inv.gz --no_text_output $folder/TestRunner.dtrace.gz |& tee $folder/daikon-output.txt"
	echo $cmd
	echo $cmd >> $folder/cmds.txt
	eval $cmd
	echo $? > $folder/result.txt
	a=$((a+1))
done <modified_classes
