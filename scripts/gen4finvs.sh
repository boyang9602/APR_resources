#!/bin/bash
test_cases=""
raw=$(tail -n 1 defects4j.build.properties | sed 's/d4j\.tests\.trigger=\(.*\)/\1/')
IFS=',' read -ra tcarr <<< $raw
for tc in ${tcarr[@]}; do
        test_cases="$test_cases$tc "
done
path="$DAIKONDIR/daikon.jar:lib/*:build/classes/:build/test/:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:/home/ubuntu/launcher/"
pptpattern=$(cat defects4j.build.properties | grep d4j.classes.modified | sed 's/d4j.classes.modified=\(.*\)/\1/' | sed 's/\.[A-Za-z]*$/\./')
pptpattern="--ppt-select-pattern=^${pptpattern//\./\\\.}"
defects4j compile
if [ -d ft_invariants_files ]; then
	rm -rf ft_invariants_files
fi
mkdir ft_invariants_files
cmd="java -Xmx43G -cp $path daikon.DynComp '$pptpattern' --output-dir=ft_invariants_files TestRunner $test_cases |& tee ft_invariants_files/dyncomp-output.txt"
echo $cmd
echo $cmd >> ft_invariants_files/cmds.txt
eval $cmd
cmd="java -Xmx43G -cp $path daikon.Chicory '$pptpattern' --heap-size=43G --comparability-file=ft_invariants_files/TestRunner.decls-DynComp --output-dir=ft_invariants_files TestRunner $test_cases |& tee ft_invariants_files/chicory-output.txt"
echo $cmd
echo $cmd >> ft_invariants_files/cmds.txt
eval $cmd
cmd="java -Xmx43G -cp $DAIKONDIR/daikon.jar daikon.Daikon -o ft_invariants_files/closure.inv.gz --no_text_output ft_invariants_files/TestRunner.dtrace.gz |& tee ft_invariants_files/daikon-output.txt"
echo $cmd
echo $cmd >> ft_invariants_files/cmds.txt
eval $cmd
echo $? > ft_invariants_files/result.txt
