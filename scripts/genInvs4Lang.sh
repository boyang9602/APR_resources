#!/bin/bash
# generate invariants using daikon for Chart project.
# due to issue: https://github.com/codespecs/daikon/issues/203, the assert statement is not enabled.

# the script is used for the below's folder structure:
# Chart
# --bug_id
# ----fixed_project
# ----buggy_project
# ----patches
# ------plausible_project_n

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

genInvs() {
	local path=$1
	cmd="cd ${path}"
	echo $cmd
	eval $cmd
	cmd="defects4j compile"
	echo $cmd
	eval $cmd
	testClsStr=$(tail defects4j.build.properties -n 1 | cut -d '=' -f 2)
	declare -a ranTests
	local count=0
	IFS=',' read -ra testClses <<< "$testClsStr"
	for testCls in "${testClses[@]}"; do
		class=$(echo $testCls | cut -d ':' -f 1)
		containsElement $class "${ranTests[@]}"
		if [ $? -eq 0 ]; then
			continue
		fi
		ranTests+=( $class )
		cmd="java -Xmx10240M -cp target/classes:target/test-classes/:$DAIKONDIR/daikon.jar daikon.DynComp --decl-file=TestRunner${count}.decls-DynComp junit.textui.TestRunner ${class}"
		echo "$cmd"
		eval "$cmd"
		cmd="java -Xmx10240M -cp target/classes:target/test-classes/:$DAIKONDIR/daikon.jar daikon.Chicory --comparability-file=TestRunner${count}.decls-DynComp --dtrace-file=TestRunner${count}.dtrace.gz junit.textui.TestRunner ${class}"
		echo "$cmd"
		eval "$cmd"
		cmd="java -Xmx10240M -cp target/classes:target/test-classes/:$DAIKONDIR/daikon.jar daikon.Daikon TestRunner${count}.dtrace.gz"
		echo "$cmd"
		eval "$cmd"
		count=$((count+1))
	done
}

root=$(pwd)
for bug_id in *; do
	cmd="cd ${root}"
	echo $cmd
	eval $cmd
	if [ ! -d $bug_id ]; then
		continue;
	fi
	genInvs $root/$bug_id/b
	genInvs $root/$bug_id/f
	cmd="cd ${root}/${bug_id}/patches"
	echo $cmd
	eval $cmd
	for patch in *; do
		genInvs $root/$bug_id/patches/$patch
	done
done