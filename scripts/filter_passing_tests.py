#!/usr/bin/python3
related_tests = set()
failing_tests = set()
with open('related_tests') as rtfile:
    for line in rtfile:
        if line.endswith('\n'):
            related_tests.add(line[:-1])
        else:
            related_tests.add(line)

with open('defects4j.build.properties') as prfile:
    for line in prfile:
        if line.startswith('d4j.tests.trigger'):
            for tc in line[18:].split(','):
                if tc.endswith('\n'):
                    failing_tests.add(tc[:-1])
                else:
                    failing_tests.add(tc)

with open('passing_tests', 'w') as pafile:
    for tc in related_tests - failing_tests:
        pafile.write(tc + '\n')
