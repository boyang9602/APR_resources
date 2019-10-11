# Chart 1

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

### Buggy code
```java
/**
 * Returns a (possibly empty) collection of legend items for the series
 * that this renderer is responsible for drawing.
 *
 * @return The legend item collection (never <code>null</code>).
 *
 * @see #getLegendItem(int, int)
 */
public LegendItemCollection getLegendItems() {
    LegendItemCollection result = new LegendItemCollection();
    if (this.plot == null) {
        return result;
    }
    int index = this.plot.getIndexOf(this);
    CategoryDataset dataset = this.plot.getDataset(index);
    if (dataset != null) {
        return result;
    }
    int seriesCount = dataset.getRowCount();
    if (plot.getRowRenderingOrder().equals(SortOrder.ASCENDING)) {
        for (int i = 0; i < seriesCount; i++) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    else {
        for (int i = seriesCount - 1; i >= 0; i--) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    return result;
}
```

### Fixed code
```java
/**
 * Returns a (possibly empty) collection of legend items for the series
 * that this renderer is responsible for drawing.
 *
 * @return The legend item collection (never <code>null</code>).
 *
 * @see #getLegendItem(int, int)
 */
public LegendItemCollection getLegendItems() {
    LegendItemCollection result = new LegendItemCollection();
    if (this.plot == null) {
        return result;
    }
    int index = this.plot.getIndexOf(this);
    CategoryDataset dataset = this.plot.getDataset(index);
    if (dataset == null) {
        return result;
    }
    int seriesCount = dataset.getRowCount();
    if (plot.getRowRenderingOrder().equals(SortOrder.ASCENDING)) {
        for (int i = 0; i < seriesCount; i++) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    else {
        for (int i = seriesCount - 1; i >= 0; i--) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    return result;
}
```

### Plausible fixed code
```java
/**
 * Returns a (possibly empty) collection of legend items for the series
 * that this renderer is responsible for drawing.
 *
 * @return The legend item collection (never <code>null</code>).
 *
 * @see #getLegendItem(int, int)
 */
public LegendItemCollection getLegendItems() {
    LegendItemCollection result = new LegendItemCollection();
    if (this.plot == null) {
        return result;
    }
    int index = this.plot.getIndexOf(this);
    CategoryDataset dataset = this.plot.getDataset(index);
    int seriesCount = dataset.getRowCount();
    if (plot.getRowRenderingOrder().equals(SortOrder.ASCENDING)) {
        for (int i = 0; i < seriesCount; i++) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    else {
        for (int i = seriesCount - 1; i >= 0; i--) {
            if (isSeriesVisibleInLegend(i)) {
                LegendItem item = getLegendItem(index, i);
                if (item != null) {
                    result.add(item);
                }
            }
        }
    }
    return result;
}
```
Uml for related classes in `test2947660()` and `getLegendItems()`: 
![uml](http://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/boyang9602/APR_resources/master/Chart/1/umls/test2947660.puml)
