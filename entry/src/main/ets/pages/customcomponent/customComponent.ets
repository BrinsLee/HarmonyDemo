/**
 * @author lipeilin
 * @date 2025/7/2
 * @project MyApplication
 * @description 描述信息
 */

@Entry
@Component
struct customComponent {
  build() {
    Column() {
      CustomLayout({builder: ColumnChildren})
    }
  }

}

@Builder
function ColumnChildren() {
  ForEach([1, 2, 3], (index: number) => { // 暂不支持lazyForEach的写法
    Text('S' + index)
      .fontSize(30)
      .width(100)
      .height(100)
      .borderWidth(2)
      .offset({ x: 10, y: 20 })
  })
}

@Component
struct CustomLayout {
  @Builder
  doNothingBuilder() {

  };

  @BuilderParam builder: () => void = this.doNothingBuilder;


  @State startSize: number = 100;
  result: SizeResult = {
    width: 0,
    height: 0
  };

  onMeasureSize(selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
    let size = 100;
    children.forEach((child) => {
      let result: MeasureResult = child.measure({minHeight: size, minWidth: size, maxWidth: size, maxHeight: size});
      size += result.width / 2;
    })
    this.result.width = 100;
    this.result.height = 400;
    return this.result;
  }

  // 第二步：放置各子组件的位置
  onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Array<Layoutable>, constraint: ConstraintSizeOptions) {
    let startPos = 300;
    children.forEach((child) => {
      let pos = startPos - child.measureResult.height;
      child.layout({ x: pos, y: pos })
    })
  }

  build() {
    this.builder()
  }
}