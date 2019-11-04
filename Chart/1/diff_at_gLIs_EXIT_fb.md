### Differences between buggy version and fixed version at `org.jfree.chart.renderer.category.AbstractCategoryItemRenderer.getLegendItems():::EXIT`

The buggy version has the following extra lines:  
```
this.paintList.size == orig(this.paintList.size) ------------------------> this.paintList.size has never been changed from beginning to any return point
this.strokeList.objects[] == orig(this.strokeList.objects[]) ------------> this.strokeList.objects[] has never been changed from beginning to any return point
this.strokeList.size == orig(this.strokeList.size) ----------------------> this.strokeList.size has never been changed from beginning to any return point
this.shapeList.objects[] == orig(this.shapeList.objects[]) --------------> this.shapeList.objects[] has never been changed from beginning to any return point
this.shapeList.size == orig(this.shapeList.size) ------------------------> this.shapeList.size has never been changed from beginning to any return point
return.items[] == [] ----------------------------------------------------> return.items[] is always [] from beginning to any return point
return.items[].getClass().getName() == [] -------------------------------> return.items[].getClass().getName() is always [] from beginning to any return point
```
The fixed version has the following extra lines:  
```
this.selectedItemAttributes.defaultCreateEntity == orig(this.selectedItemAttributes.defaultCreateEntity)
size(this.paintList.objects[]) == orig(size(this.paintList.objects[])) ------------↘
size(this.strokeList.objects[]) == orig(size(this.strokeList.objects[])) -----------> I think they have the same meaning with the buggy version's invariants of these elements.
size(this.shapeList.objects[]) == orig(size(this.shapeList.objects[])) ------------↗
return.items[] elements has only one value -----------------------------------------> The element of the return.items[] is hashcode or address
return.items[].getClass().getName() elements == org.jfree.chart.LegendItem.class ---> Each element's class is org.jfree.chart.LegendItem
return.items[].getClass().getName() one of { [], [org.jfree.chart.LegendItem] } ----> At the first EXIT point, it is [], last EXIT point it is [org.jfree.chart.LegendItem]
size(return.items[]) one of { 0, 1 } -----------------------------------------------> At the first EXIT point, the size is 0 and last EXIT point the size is 1
```

1. `size(.*)` is one of the daikon's `keywork` to represents an array's size.  
2. `.size` is a field of `AbstractObjectList` in `Chart` project and `PaintList`, `StrokeList`, ... inherits from the `AbstractObjectList`.  

So between the buggy version and fixed version for `getLegendItems():::EXIT`, the main differences are about the `return.items`, one is always empty and another one could have value.   

##### Has only one value:
>The output ‘var has only one value’ in Daikon’s output means that every time that variable var was encountered, it had the same value. Daikon ordinarily reports the actual value, as in ‘var == 22’. Typically, the “has only one value” output means that the variable is a hashcode or address — that is, its declared type is ‘hashcode’ (see Variable declarations in Daikon Developer Manual). For example, ‘var == 0x38E8A’ is not very illuminating, but it is still interesting that var was never rebound to a different object.

>Note that ‘var has only one value’ is different from saying that var is unmodified.

>A variable might have only one value but not be reported as unmodified because the variable is not a parameter to a procedure — for instance, if a routine always returns the same object, or in a class invariant. A variable can be reported as unmodified but not have only one value because the variable is never modified during any execution of the procedure, but has different values on different invocations of the procedure.