#!/bin/bash
test_cases=""
while read tc; do
	test_cases="$test_cases$tc "
done < $1
path="$DAIKONDIR/daikon.jar:lib/*:build/classes/:build/test/:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:/home/ubuntu/launcher/"
pptpattern=$(cat defects4j.build.properties | grep d4j.classes.modified | sed 's/d4j.classes.modified=\(.*\)/\1/' | sed 's/\.[A-Za-z]*$/\./')
pptpattern="--ppt-select-pattern=^${pptpattern//\./\\\.}"
defects4j compile
if [ -d pt_invariants_files ]; then
	rm -rf pt_invariants_files
fi
mkdir pt_invariants_files
cmd="java -Xmx43G -cp $path daikon.DynComp '$pptpattern' --output-dir=pt_invariants_files TestRunner $test_cases |& tee pt_invariants_files/dyncomp-output.txt"
echo $cmd
echo $cmd >> pt_invariants_files/cmds.txt
eval $cmd
cmd="java -Xmx43G -cp $path daikon.Chicory '$pptpattern' --heap-size=43G --comparability-file=pt_invariants_files/TestRunner.decls-DynComp --output-dir=pt_invariants_files TestRunner $test_cases |& tee pt_invariants_files/chicory-output.txt"
echo $cmd
echo $cmd >> pt_invariants_files/cmds.txt
eval $cmd
cmd="java -Xmx43G -cp $DAIKONDIR/daikon.jar daikon.Daikon -o pt_invariants_files/closure.inv.gz --no_text_output pt_invariants_files/TestRunner.dtrace.gz |& tee pt_invariants_files/daikon-output.txt"
echo $cmd
echo $cmd >> pt_invariants_files/cmds.txt
eval $cmd
echo $? > pt_invariants_files/result.txt
