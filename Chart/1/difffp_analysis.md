### [difffp](./data/difffp.json)([visual](https://observablehq.com/d/06c8d17ba1b86512)) analysis

#### `this.plot == null`
1. (`this.plot == null`) ==> (`return.items[] == []`)  
In both version (fixed and plausible), `this.plot == null` means `return.items[] == []`  
In plausible version, only `this.plot == null` can lead to `return.items[] == []`. However, in fixed version, both `this.plot == null` and `dataset == null` can lead to `return.items[] == []`  
`return.items[].getClass().getName() == []` is the same case.  

2. (`this.plot == null`)  ==>  (`this.paintList.objects[]` contains only nulls and has only one value, of length 8)  
`this.paintList.objects[]` is initialized as an array, filled with 8 null  
Both `this.plot == null` and `dataset == null` will make `getLegendItems return in advance`, which will keep `this.paintList.objects` unmodified. So same as **1**, plausible version has 2 possible reasons while fixed version only have 1 reason.  
Other invariants related to `this.paintList`, `this.shapeList` are the same case `this.strokeList`  

3. (`this.plot == null`)  <==>  (`org.jfree.chart.renderer.AbstractRenderer.class$org$jfree$chart$event$RendererChangeListener == null`)  
// TODO  

#### `this.plot has only one value`
// TODO