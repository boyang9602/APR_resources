#!/bin/python3
# -*- coding: utf-8 -*-
import json
import os
import sys

with open('metadata2.json', 'r') as f:
	metadata = json.load(f)

for pro in metadata:
	name = pro['name']
	# os.mkdir(name)
	for bug in pro['bugs']:
		bid = bug['ID']
		os.mkdir(f'{name}/{bid}')
		os.system(f'defects4j checkout -p {name} -v {bid}b -w {name}/{bid}/{name}{bid}b')
		os.system(f'defects4j checkout -p {name} -v {bid}f -w {name}/{bid}/{name}{bid}f')
		for patch in bug['patches']:
			os.system(f'defects4j checkout -p {name} -v {bid}b -w {name}/{bid}/{name}{bid}_{patch["ID"]}')
			os.system(f'sed -i "/d4j.classes.modified/c\\d4j.classes.modified={",".join(patch["modified_classes"])}" {name}/{bid}/{name}{bid}_{patch["ID"]}/defects4j.build.properties')
