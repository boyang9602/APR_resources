# Closure
Tried version 10f, `com.google.javascript.jscomp.PeepholeFoldConstantsTest` test.  
Failed with Chicory due to exception:
```
Exception in thread "main" java.lang.NoClassDefFoundError: com.google.common.base.CharMatcher
	at java.lang.Class.getDeclaredConstructors0(Native Method)
	at java.lang.Class.privateGetDeclaredConstructors(Class.java:2671)
	at java.lang.Class.getConstructor0(Class.java:3075)
	at java.lang.Class.getDeclaredConstructor(Class.java:2178)
	at daikon.chicory.MethodInfo.initViaReflection(MethodInfo.java:153)
	at daikon.chicory.ClassInfo.initViaReflection(ClassInfo.java:87)
	at daikon.chicory.Runtime.process_new_classes(Runtime.java:451)
	at daikon.chicory.Runtime.enter(Runtime.java:236)
	at junit.framework.TestResult.addError(TestResult.java:36)
	at junit.framework.TestResult.runProtected(TestResult.java:137)
	at junit.framework.TestResult.run(TestResult.java:113)
	at junit.framework.TestCase.run(TestCase.java:124)
	at junit.framework.TestSuite.runTest(TestSuite.java:243)
	at junit.framework.TestSuite.run(TestSuite.java:238)
	at junit.textui.TestRunner.doRun(TestRunner.java:116)
	at junit.textui.TestRunner.start(TestRunner.java:180)
	at junit.textui.TestRunner.main(TestRunner.java:138)
```
### Checking measures:

Manually checked, the class **does** exist in `guava.jar`.  

It works well when I run the test directly:
```
$ java -cp build/classes/:build/test/:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:lib/* junit.textui.TestRunner com.google.javascript.jscomp.PeepholeFoldConstantsTest
.
Time: 0.191

OK (1 test)
``` 
It works well with daikon.DynComp:  
```
$ time java -Xmx12288M -cp build/classes/:build/test/:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:lib/*:$DAIKONDIR/daikon.jar daikon.DynComp junit.textui.TestRunner com.google.javascript.jscomp.PeepholeFoldConstantsTest
.
Time: 287.206

OK (1 test)


real	4m52.357s
user	5m12.866s
sys	0m1.551s
```
I cannot reproduce it any more. It always fails with the below exception while I have already allocated the maximum memory I can (14G).
```
$ time java -Xmx14288M -cp build/classes/:build/test/:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:lib/*:$DAIKONDIR/daikon.jar daikon.Chicory --comparability-file=TestRunner.decls-DynComp junit.textui.TestRunner com.google.javascript.jscomp.PeepholeFoldConstantsTest

..... 

Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
	at java.lang.reflect.Field.copy(Field.java:150)
	at java.lang.reflect.ReflectAccess.copyField(ReflectAccess.java:144)
	at sun.reflect.ReflectionFactory.copyField(ReflectionFactory.java:323)
	at java.lang.Class.copyFields(Class.java:3115)
	at java.lang.Class.getDeclaredFields(Class.java:1916)
	at daikon.chicory.DaikonVariableInfo.addClassVars(DaikonVariableInfo.java:464)
	at daikon.chicory.DaikonVariableInfo.addChildNodes(DaikonVariableInfo.java:1159)
	at daikon.chicory.DaikonVariableInfo.addClassVars(DaikonVariableInfo.java:538)
	at daikon.chicory.RootInfo.exit_process(RootInfo.java:74)
	at daikon.chicory.Runtime.process_new_classes(Runtime.java:457)
	at daikon.chicory.Runtime.exit(Runtime.java:332)
	at junit.runner.BaseTestRunner.loadSuiteClass(BaseTestRunner.java:207)
	at junit.runner.BaseTestRunner.getTest(BaseTestRunner.java:100)
	at junit.textui.TestRunner.start(TestRunner.java:179)
	at junit.textui.TestRunner.main(TestRunner.java:138)
Warning: Target exited with 1 status
```


Another exception occurs many times during the daikon.Chicory's execution:
```
Unexpected exception encountered: java.lang.RuntimeException: Invalid StackMap offset 3: Invalid StackMap offset 3
	at org.plumelib.bcelutil.StackMapUtils.modify_stack_maps_for_switches(StackMapUtils.java:363)
	at daikon.chicory.Instrument.instrument_all_methods(Instrument.java:517)
	at daikon.chicory.Instrument.transform(Instrument.java:204)
	at sun.instrument.TransformerManager.transform(TransformerManager.java:188)
	at sun.instrument.InstrumentationImpl.transform(InstrumentationImpl.java:428)
	at java.lang.ClassLoader.defineClass1(Native Method)
	at java.lang.ClassLoader.defineClass(ClassLoader.java:763)
	at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
	at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
	at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
	at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
	at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
	at java.lang.Class.getDeclaringClass0(Native Method)
	at java.lang.Class.getDeclaringClass(Class.java:1235)
	at java.lang.Class.getEnclosingClass(Class.java:1277)
	at java.lang.Class.getSimpleBinaryName(Class.java:1443)
	at java.lang.Class.getSimpleName(Class.java:1309)
	at daikon.chicory.DaikonWriter.methodName(DaikonWriter.java:169)
	at daikon.chicory.DaikonWriter.methodEntryName(DaikonWriter.java:46)
	at daikon.chicory.DeclWriter.print_decl_class(DeclWriter.java:273)
	at daikon.chicory.DeclWriter.printDeclClass(DeclWriter.java:120)
	at daikon.chicory.Runtime.process_new_classes(Runtime.java:460)
	at daikon.chicory.Runtime.exit(Runtime.java:332)
	at com.google.javascript.rhino.head.Kit.classOrNull(Kit.java:74)
	at com.google.javascript.rhino.head.Context.<clinit>(Context.java:2439)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:264)
	at com.google.javascript.rhino.head.Kit.classOrNull(Kit.java:74)
	at com.google.javascript.rhino.head.ScriptRuntime.<clinit>(ScriptRuntime.java:157)
	at com.google.javascript.jscomp.RhinoErrorReporter.<init>(RhinoErrorReporter.java:72)
	at com.google.javascript.jscomp.RhinoErrorReporter.<init>(RhinoErrorReporter.java:32)
	at com.google.javascript.jscomp.RhinoErrorReporter$OldRhinoErrorReporter.<init>(RhinoErrorReporter.java:135)
	at com.google.javascript.jscomp.RhinoErrorReporter$OldRhinoErrorReporter.<init>(RhinoErrorReporter.java:131)
	at com.google.javascript.jscomp.RhinoErrorReporter.forOldRhino(RhinoErrorReporter.java:100)
	at com.google.javascript.jscomp.Compiler.<init>(Compiler.java:168)
	at com.google.javascript.jscomp.Compiler.<init>(Compiler.java:230)
	at com.google.javascript.jscomp.CompilerTestCase.createCompiler(CompilerTestCase.java:1058)
	at com.google.javascript.jscomp.CompilerTestCase.test(CompilerTestCase.java:429)
	at com.google.javascript.jscomp.CompilerTestCase.test(CompilerTestCase.java:371)
	at com.google.javascript.jscomp.CompilerTestCase.test(CompilerTestCase.java:340)
	at com.google.javascript.jscomp.CompilerTestCase.test(CompilerTestCase.java:328)
	at com.google.javascript.jscomp.CompilerTestCase.testSame(CompilerTestCase.java:560)
	at com.google.javascript.jscomp.PeepholeFoldConstantsTest.foldSame(PeepholeFoldConstantsTest.java:66)
	at com.google.javascript.jscomp.PeepholeFoldConstantsTest.testIssue821(PeepholeFoldConstantsTest.java:73)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at junit.framework.TestCase.runTest(TestCase.java:168)
	at junit.framework.TestCase.runBare(TestCase.java:134)
	at junit.framework.TestResult$1.protect(TestResult.java:110)
	at junit.framework.TestResult.runProtected(TestResult.java:128)
	at junit.framework.TestResult.run(TestResult.java:113)
	at junit.framework.TestCase.run(TestCase.java:124)
	at junit.framework.TestSuite.runTest(TestSuite.java:243)
	at junit.framework.TestSuite.run(TestSuite.java:238)
	at junit.textui.TestRunner.doRun(TestRunner.java:116)
	at junit.textui.TestRunner.start(TestRunner.java:180)
	at junit.textui.TestRunner.main(TestRunner.java:138)

```
