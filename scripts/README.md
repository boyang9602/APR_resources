Here are some scripts for automatic tasks:  
1. [genAll.sh](./genAll.sh) is used to checkout all the projects which have been patched and evaluated correctness from defects4j. For the projects information, please refer to: https://github.com/Ultimanecat/DefectRepairing  
2. [genInvs4Chart.sh](./genInvs4Chart.sh) is used to generate invariants for Chart projects in batch with the directory structure of the results of [genAll.sh](./genAll.sh). You need to patch the projects manually.  
3. [genInvs4Chart.sh](./genInvs4Chart.sh) is used to generate invariants for Lang.  
4. [genInvs4Math.sh](./genInvs4Math.sh) is used to generate invariants for Math.  
5. [outputInvs.sh](./outputInvs.sh) is used to select and output invariants.  
6. [coverageTests.sh](./coverageTests.sh) is used to do coverage test for each test case and find the tests cases related to the buggy class.  
7. [filterCoverageTests.py](./filterCoverageTests.py) is used to do filter the passing tests that cover the buggy method from the coverage reports in [coverageTests.sh](./coverageTests.sh).