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

convTestCaseFormat() {
    local testStr=$1
    class=$(echo $testStr | sed 's/.*(\(.*\))/\1/')
    _case=$(echo $testStr | sed 's/\(.*\)(.*)/\1/')
}

covTest() {
    local path=$1
    cmd="cd ${path}"
    echo $cmd
    eval $cmd
    cmd="git add ."
    echo $cmd
    eval $cmd
    cmd="git stash"
    echo $cmd
    eval $cmd
    cmd="git stash clear"
    echo $cmd
    eval $cmd
    cmd="defects4j compile"
    echo $cmd
    eval $cmd
    cmd="defects4j test"
    echo $cmd
    eval $cmd
    cmd="mv all_tests tests_list"
    echo $cmd
    eval $cmd
    # read tests_list line by line
    while read -r line; do
        convTestCaseFormat $line
        cmd="defects4j coverage -t $class::$_case"
        echo $cmd
        eval $cmd
        if [[ $(tail -n 1 summary.csv | awk -F , '{print $2}') > 0 ]]; then
            mv coverage.xml ../coverages/${class}_${_case}_coverage.xml
        fi
    done < tests_list
}

root=$(pwd)
for bug_id in *; do
    cmd="cd ${root}"
    echo $cmd
    eval $cmd
    if [ ! -d $bug_id -o $bug_id = coverages ]; then
        continue;
    fi
    if [[ ! -d $root/$bug_id/coverages ]]; then
        mkdir $root/$bug_id/coverages   
    fi
    covTest $root/$bug_id/b
done