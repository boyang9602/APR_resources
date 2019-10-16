# Chart 1
Chart project from defects4j, id: 1  
[buggy code](./codes/_buggy.md)  
[fixed code](./codes/_fixed.md)  
[plausible code](./codes/_plausible.md)  
### Test case:
```java
/**
 * A test that reproduces the problem reported in bug 2947660.
 */
public void test2947660() {
    AbstractCategoryItemRenderer r = new LineAndShapeRenderer();
    assertNotNull(r.getLegendItems());
    assertEquals(0, r.getLegendItems().getItemCount());

    DefaultCategoryDataset dataset = new DefaultCategoryDataset();
    CategoryPlot plot = new CategoryPlot();
    plot.setDataset(dataset);
    plot.setRenderer(r);
    assertEquals(0, r.getLegendItems().getItemCount());

    dataset.addValue(1.0, "S1", "C1");
    LegendItemCollection lic = r.getLegendItems();
    assertEquals(1, lic.getItemCount());
    assertEquals("S1", lic.get(0).getLabel());
}
```
![uml](http://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/boyang9602/APR_resources/master/Chart/1/umls/test2947660.puml?t=0)
