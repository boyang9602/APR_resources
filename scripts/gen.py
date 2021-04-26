#!/bin/python3
# -*- coding: utf-8 -*-
import json
import os
import sys

with open('metadata2.json', 'r') as f:
	metadata = json.load(f)

def list_equals(l1, l2):
	if len(l1) != len(l2):
		return False
	for e in l1:
		if e not in l2:
			return False
	return True

for pro in metadata:
	name = pro['name']
	os.mkdir(name)
	for bug in pro['bugs']:
		bid = bug['ID']
		os.mkdir(f'{name}/{bid}')
		os.system(f'defects4j checkout -p {name} -v {bid}f -w {name}/{bid}/{name}{bid}f')
		groups = [{'patch': ['dev']}]
		group0 = groups[0]
		with open(f'{name}/{bid}/{name}{bid}f/defects4j.build.properties', 'r') as f:
			for line in f:
				if line.startswith('d4j.classes.modified='):
					dev_modified_classes = line[21:].strip().split(',')
					group0['modified_classes'] = dev_modified_classes
					break
		os.system(f'echo {",".join(group0["modified_classes"])} >> {name}/{bid}/{name}{bid}f/modified_classes')

		# check out buggy version, then another script will patch them using APR patches
		for patch in bug['patches']:
			os.system(f'defects4j checkout -p {name} -v {bid}b -w {name}/{bid}/{name}{bid}_{patch["ID"]}')
			# os.system(f'sed -i "/d4j.classes.modified/c\\d4j.classes.modified={",".join(patch["modified_classes"])}" {name}/{bid}/{name}{bid}_{patch["ID"]}/defects4j.build.properties')
			os.system(f'echo {",".join(patch["modified_classes"])} >> {name}/{bid}/{name}{bid}_{patch["ID"]}/modified_classes')
			found = False
			for group in groups:
				if list_equals(group['modified_classes'], patch['modified_classes']):
					group['patch'].append(patch['ID'])
					found = True
					break

			if not found:
				groups.append({'patch': [patch['ID']], 'modified_classes': patch['modified_classes']})

		# check out buggy version
		os.system(f'defects4j checkout -p {name} -v {bid}b -w {name}/{bid}/{name}{bid}b')
		for group in groups:
			os.system(f'echo {",".join(group["modified_classes"])} >> {name}/{bid}/{name}{bid}b/modified_classes')
