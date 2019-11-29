# Compare directly generated invs and merged invs
Commands to generate comparability file:
```
java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.DynComp '--ppt-omit-pattern=^junit\.' junit.textui.TestRunner com.google.javascript.jscomp.CommandLineRunnerTest
```
Commands to generate separately and merged:
```
# generate for package com.google.javascript.jscomp, not include the subpackages.
java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Chicory '--ppt-select-pattern=^com.google.javascript.jscomp.[A-Z]' --heap-size=25G --comparability-file=TestRunner.decls-DynComp --dtrace-file=jscomp.dtrace.gz junit.textui.TestRunner com.google.javascript.jscomp.CommandLineRunnerTest
java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Daikon -o jscomp.inv.gz jscomp.dtrace.gz

# generate for package com.google.javascript.jscomp.deps
java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Chicory '--ppt-select-pattern=^com.google.javascript.jscomp.deps.[A-Z]' --heap-size=25G --comparability-file=TestRunner.decls-DynComp --dtrace-file=deps.dtrace.gz junit.textui.TestRunner com.google.javascript.jscomp.CommandLineRunnerTest
java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Daikon -o deps.inv.gz deps.dtrace.gz

java -Xmx25G -cp $DAIKONDIR/daikon.jar daikon.MergeInvariants -o merged.inv.gz deps.inv.gz jscomp.inv.gz
```
Commands to generate directly:
```
$ java -Xmx25G -cp $DAIKONDIR/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Chicory '--ppt-select-pattern=^com.google.javascript.jscomp.deps.[A-Z]' '--ppt-select-pattern=^com.google.javascript.jscomp.[A-Z]' --heap-size=25G --comparability-file=TestRunner.decls-DynComp --dtrace-file=directly.dtrace.gz --output-dir=inv_files junit.textui.TestRunner com.google.javascript.jscomp.CommandLineRunnerTest
java -Xmx25G -cp /home/users/byang/projects/daikon-5.7.2/daikon.jar:lib/*:build/lib/rhino.jar:build/lib/rhino1_7R5pre/js.jar:build/classes/:build/test/ daikon.Daikon --no_text_output -o directly.inv.gz directly.dtrace.gz
```
Compare the difference between directly generated invariants and separated generated and merged invariants:
```
$ java -Xmx25G -cp $DAIKONDIR/daikon.jar daikon.diff.Diff merged.inv.gz directly.inv.gz 
<com.google.javascript.jscomp.AbstractCommandLineRunner$RunTimeStats.recordEndRun():::ENTER>
  <com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner$RunTimeStats.recordEndRun():::EXIT>
  <com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.bestRunTime one of { 5931, 9595, 10489 } {1+}, com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.bestRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.worstRunTime one of { 5931, 9595, 10489 } {1+}, com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.worstRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <this.bestRunTime one of { 5931, 9595, 10489 } {1+}, this.bestRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <this.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.worstRunTime one of { 5931, 9595, 10489 } {1+}, this.worstRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner$RunTimeStats.recordStartRun():::EXIT>
  <com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, com.google.javascript.jscomp.AbstractCommandLineRunner.this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.constructRootRelativePathsMap():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.constructRootRelativePathsMap():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.createExterns():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.createExterns():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.createSourceInputs(java.util.List):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.createSourceInputs(java.util.List):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.doRun():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.doRun():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getCompiler():::ENTER>
  <this.runTimeStats.bestRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.bestRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.runTimeStats.worstRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.worstRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getCompiler():::EXIT>
  <this.runTimeStats.bestRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.bestRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.runTimeStats.worstRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.worstRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getDiagnosticGroups():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getDiagnosticGroups():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getInputCharset():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getInputCharset():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getLegacyOutputCharset():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getLegacyOutputCharset():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getOutputCharset2():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.getOutputCharset2():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.isInTestMode():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.isInTestMode():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputBundle():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputBundle():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputManifest():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputManifest():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputManifestOrBundle(java.util.List, boolean):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputManifestOrBundle(java.util.List, boolean):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputModuleGraphJson():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputModuleGraphJson():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputNameMaps(com.google.javascript.jscomp.CompilerOptions):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputNameMaps(com.google.javascript.jscomp.CompilerOptions):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputSingleBinary():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputSingleBinary():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputSourceMap(com.google.javascript.jscomp.CompilerOptions, java.lang.String):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.outputSourceMap(com.google.javascript.jscomp.CompilerOptions, java.lang.String):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.processResults(com.google.javascript.jscomp.Result, java.util.List, com.google.javascript.jscomp.CompilerOptions):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.processResults(com.google.javascript.jscomp.Result, java.util.List, com.google.javascript.jscomp.CompilerOptions):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.run():::EXIT>
  <this.runTimeStats.bestRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.bestRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
  <this.runTimeStats.worstRunTime one of { 5931, 9595, 10489 } {1+}, this.runTimeStats.worstRunTime one of { 5821, 9579, 10253 } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.setRunOptions(com.google.javascript.jscomp.CompilerOptions):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.setRunOptions(com.google.javascript.jscomp.CompilerOptions):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.streamToLegacyOutputWriter(java.io.OutputStream):::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.AbstractCommandLineRunner.streamToLegacyOutputWriter(java.io.OutputStream):::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.CodeGenerator.CodeGenerator(com.google.javascript.jscomp.CodeConsumer, com.google.javascript.jscomp.CompilerOptions):::ENTER>
  <com.google.javascript.jscomp.AnonymousFunctionNamingPolicy.$VALUES[..].reservedCharacters sorted by < {0.999+}, null> (Una,JM)
<com.google.javascript.jscomp.CodeGenerator.CodeGenerator(com.google.javascript.jscomp.CodeConsumer, com.google.javascript.jscomp.CompilerOptions):::EXIT>
  <com.google.javascript.jscomp.AnonymousFunctionNamingPolicy.$VALUES[..].reservedCharacters sorted by < {0.999+}, null> (Una,JM)
<com.google.javascript.jscomp.CodePrinter.toSource(com.google.javascript.rhino.Node, com.google.javascript.jscomp.CodePrinter$Format, com.google.javascript.jscomp.CompilerOptions, com.google.javascript.jscomp.SourceMap, boolean):::ENTER>
  <com.google.javascript.jscomp.AnonymousFunctionNamingPolicy.$VALUES[..].reservedCharacters sorted by < {0.999+}, null> (Una,JM)
<com.google.javascript.jscomp.CodePrinter.toSource(com.google.javascript.rhino.Node, com.google.javascript.jscomp.CodePrinter$Format, com.google.javascript.jscomp.CompilerOptions, com.google.javascript.jscomp.SourceMap, boolean):::EXIT>
  <com.google.javascript.jscomp.AnonymousFunctionNamingPolicy.$VALUES[..].reservedCharacters sorted by < {0.999+}, null> (Una,JM)
<com.google.javascript.jscomp.CommandLineRunner.createExterns():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.CommandLineRunner.createExterns():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.CommandLineRunner.createOptions():::ENTER>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.CommandLineRunner.createOptions():::EXIT>
  <this.runTimeStats.lastStartTime one of { 1575050997022L, 1575051007047L, 1575051017992L } {1+}, this.runTimeStats.lastStartTime one of { 1575056473559L, 1575056483559L, 1575056494260L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.NodeTraversal.getCompiler():::EXIT>
  <return.currentTracer.startTimeMs one of { 1575051000601L, 1575051012899L, 1575051019618L } {1+}, return.currentTracer.startTimeMs one of { 1575056477166L, 1575056489264L, 1575056495836L } {1+}> (Una,DJJ)
<com.google.javascript.jscomp.deps.JsFileLineParser.doParse(java.lang.String, java.io.Reader):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
<com.google.javascript.jscomp.deps.JsFileLineParser.parseJsString(java.lang.String):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
<com.google.javascript.jscomp.deps.JsFileParser.parseFile(java.lang.String, java.lang.String, java.lang.String):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
<com.google.javascript.jscomp.deps.JsFileParser.parseLine(java.lang.String):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
<com.google.javascript.jscomp.deps.JsFileParser.parseReader(java.lang.String, java.lang.String, java.io.Reader):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
<com.google.javascript.jscomp.deps.JsFileParser.setIncludeGoogBase(boolean):::EXIT>
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES == orig(com.google.javascript.jscomp.CheckLevel.$VALUES) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.ERROR == orig(com.google.javascript.jscomp.CheckLevel.ERROR) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.OFF == orig(com.google.javascript.jscomp.CheckLevel.OFF) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.WARNING == orig(com.google.javascript.jscomp.CheckLevel.WARNING) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.defaultLevel) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.format) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.level) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES[..] == orig(com.google.javascript.jscomp.CheckLevel.$VALUES[..]) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName() == orig(com.google.javascript.jscomp.CheckLevel.$VALUES.getClass().getName()) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_ERROR.key.toString) {1+}> (Bin,MJ)
  <null, com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString == orig(com.google.javascript.jscomp.deps.JsFileLineParser.PARSE_WARNING.key.toString) {1+}> (Bin,MJ)
```