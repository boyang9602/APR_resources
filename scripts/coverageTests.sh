#!/bin/bash

# the script is used for the below's folder structure:
# project_name
# --bug_id
# ----{project_name}{bug_id}b
# ----{project_name}{bug_id}f
# ----{project_name}{bug_id}_Patch{patch_id}

convTestCaseFormat() {
    local testStr=$1
    class=$(echo $testStr | sed 's/.*(\(.*\))/\1/')
    _case=$(echo $testStr | sed 's/\(.*\)(.*)/\1/')
}

covTest() {
    local path=$1/$2/*b
    cmd="cd ${path}"
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
    a=0
    while read -r cls; do
        IFS=',' read -ra ADDR <<< "$cls"
        for i in "${ADDR[@]}"; do
            echo $i >> instrument_classes
        done
        # read tests_list line by line
        if [[ ! -d coverages$a ]]; then
            mkdir coverages$a
        fi
        while read -r line; do
            convTestCaseFormat $line
            cmd="defects4j coverage -i $instrument_classes -t $class::$_case"
            echo $cmd
            eval $cmd
            mv coverage.xml coverages$a/${class}_SEP_${_case}_SEP_coverage.xml
        done < tests_list
        a=$((a+1))
    done < modified_classes
}

root=$(pwd)
for bug_id in *; do
    cmd="cd ${root}"
    echo $cmd
    eval $cmd
    if [[ ! -d $bug_id ]]; then
        continue;
    fi
    covTest $root $bug_id
done