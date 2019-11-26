#!/usr/bin/python3
from os import listdir
from os.path import isdir
import xml.etree.ElementTree as ET
import json

def read_buggy_methods(parent_path):
    with open(parent_path + "/buggy_methods.json") as f:
        return json.loads(f.read())

        
for b_version in [d for d in listdir() if isdir(d)]:
    passing_tests = []
    j_buggy_methods = read_buggy_methods(b_version)
    for coverage_file in listdir(b_version + '/coverages'):
        words = coverage_file.split('_')
        test_class = words[0]
        test_case = '_'.join(words[1:-1])
        tree = ET.parse(b_version + '/coverages/' + coverage_file)
        root = tree.getroot()
        packages = root.findall("packages/package")
        for x_package in packages:
            for j_package in j_buggy_methods['packages']:
                if j_package['name'] == x_package.attrib['name']:
                    classes = x_package.findall("classes/class")
                    for x_class in classes:
                        for j_class in j_package['classes']:
                            if j_class['name'] == x_class.attrib['name']:
                                methods = x_class.findall('methods/method')
                                for x_method in methods:
                                    for j_method in j_class['methods']:
                                        if x_method.attrib['name'] == j_method['name'] and x_method.attrib['signature'] == j_method['signature'] and float(x_method.attrib['line-rate']) > 0:
                                            if not test_class + "::" + test_case in passing_tests:
                                                passing_tests.append(test_class + "::" + test_case)
                                break
                    break
    with open(b_version + '/related_tests', 'w') as passing_tests_file:
        for test in passing_tests:
            passing_tests_file.write(test + '\n')