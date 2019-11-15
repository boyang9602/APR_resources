#!/bin/bash

#1-19, 85-93, 188, 189

checkAll() {
	local base=$1
	echo "cd ${base}"
	cd $base
	local project=$2
	if [[ ! -d ./$project ]]; then
		echo "mkdir ${project}"
		mkdir $project
	fi
	echo "cd ${project}"
	cd $project
	local bug_id=$3
	local patch_id=$4
	if [[ ! -d ./$bug_id ]]; then
		echo "mkdir ${bug_id}"
		mkdir $bug_id
	fi
	echo "cd ${bug_id}"
	cd $bug_id
	if [[ ! -d ./b ]]; then
		cmd="defects4j checkout -p $project -v ${bug_id}b -w b"
		echo $cmd
		eval $cmd
	fi
	if [[ ! -d ./f ]]; then
		cmd="defects4j checkout -p $project -v ${bug_id}f -w f"
		echo $cmd
		eval $cmd
	fi
	if [[ ! -d ./patches ]]; then
		echo "mkdir patches"
		mkdir patches
	fi
	echo "cd patches"
	cd patches
	cmd="defects4j checkout -p $project -v ${bug_id}b -w ${patch_id}"
	echo $cmd
	eval $cmd
}

files=$(ls ~/projects/DefectRepairing/tool/patches/INFO)
for file in $files; do
	project=$(cat ~/projects/DefectRepairing/tool/patches/INFO/$file | jq -r .project)
	bug_id=$(cat ~/projects/DefectRepairing/tool/patches/INFO/$file | jq -r .bug_id)
	patch_id=$(cat ~/projects/DefectRepairing/tool/patches/INFO/$file | jq -r .ID)
	checkAll ~/projects/d4js $project $bug_id $patch_id
done