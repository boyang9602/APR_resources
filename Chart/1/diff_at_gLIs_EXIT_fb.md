# Differences between buggy version and fixed version at `org.jfree.chart.renderer.category.AbstractCategoryItemRenderer.getLegendItems():::EXIT(ID)`
### First `EXIT` point  
For buggy version, it's `EXIT1793`, fixed version is the same.  
Common part is:  
`this.plot == null`
`org.jfree.chart.renderer.AbstractRenderer.class$org$jfree$chart$event$RendererChangeListener == null`
Different part is fixed version has the following extra lines:  
```
this.paintList.objects[] == orig(this.paintList.objects[])
this.paintList.size == orig(this.paintList.size)
this.strokeList.objects[] == orig(this.strokeList.objects[])
this.strokeList.size == orig(this.strokeList.size)
this.shapeList.objects[] == orig(this.shapeList.objects[])
this.shapeList.size == orig(this.shapeList.size)
this.plot == null
this.paintList.objects[] contains only nulls and has only one value, of length 8
this.paintList.objects[] elements == null
this.paintList.objects[].getClass().getName() == [null, null, null, null, null, null, null, null]
this.paintList.objects[].getClass().getName() elements == null
this.paintList.size == 0
this.strokeList.objects[] contains only nulls and has only one value, of length 8
this.strokeList.objects[] elements == null
this.strokeList.objects[].getClass().getName() == [null, null, null, null, null, null, null, null]
this.strokeList.objects[].getClass().getName() elements == null
this.strokeList.size == 0
this.shapeList.objects[] contains only nulls and has only one value, of length 8
this.shapeList.objects[] elements == null
this.shapeList.objects[].getClass().getName() == [null, null, null, null, null, null, null, null]
this.shapeList.objects[].getClass().getName() elements == null
this.shapeList.size == 0
return.items[] == []
return.items[].getClass().getName() == []
```

### Second `EXIT` point  
Totally same except line number.  

### All `EXIT` point (the one without `ID` (i.e. line number))  
The buggy version has the following extra lines:  
```
this.paintList.size == orig(this.paintList.size)
this.strokeList.objects[] == orig(this.strokeList.objects[])
this.strokeList.size == orig(this.strokeList.size)
this.shapeList.objects[] == orig(this.shapeList.objects[])
this.shapeList.size == orig(this.shapeList.size)
return.items[] == []
return.items[].getClass().getName() == []
```
The fixed version has the following extra lines:  
```
this.selectedItemAttributes.defaultCreateEntity == orig(this.selectedItemAttributes.defaultCreateEntity)
size(this.paintList.objects[]) == orig(size(this.paintList.objects[]))
size(this.strokeList.objects[]) == orig(size(this.strokeList.objects[]))
size(this.shapeList.objects[]) == orig(size(this.shapeList.objects[]))
return.items[] elements has only one value
return.items[].getClass().getName() elements == org.jfree.chart.LegendItem.class
return.items[].getClass().getName() one of { [], [org.jfree.chart.LegendItem] }
size(return.items[]) one of { 0, 1 }
```