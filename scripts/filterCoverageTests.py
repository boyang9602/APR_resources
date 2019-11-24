#!/usr/bin/python3
from os import listdir
from os.path import isdir
import xml.etree.ElementTree as ET

def get_buggy_method_info(parent_path):
    with open(parent_path + '/buggy_method.info') as buggy_method_info:
        name = buggy_method_info.readline().rstrip().split('=')[1]
        signature = buggy_method_info.readline().rstrip().split('=')[1]
        return name, signature
        
for b_version in [d for d in listdir() if isdir(d)]:
    passing_tests = []
    buggy_method_name, buggy_method_signature = get_buggy_method_info(b_version)
    for coverage_file in listdir(b_version + '/coverages'):
        test_class, test_case, _ = coverage_file.split('_')
        tree = ET.parse(b_version + '/coverages/' + coverage_file)
        root = tree.getroot()
        methods = root.findall("packages/package/classes/class/methods/method")
        for method in methods:
            if method.attrib['name'] == buggy_method_name and method.attrib['signature'] == buggy_method_signature and float(method.attrib['line-rate']) > 0:
                passing_tests.append(test_class + "::" + test_case)
    with open(b_version + '/passing_tests', 'w') as passing_tests_file:
        for test in passing_tests:
            passing_tests_file.write(test + '\n')