/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 界面渲染
 */

@Entry
@Component
struct Index {

  @State
  show: boolean = true

  build() {
    Column({ space: 20 }){
      // 条件渲染
      if (this.show) {
        // 累计的 count 切换时候不会保留
        CounterComp()
      }
      Button('toggle')
        .onClick(() => {
          this.show = !this.show
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct CounterComp {
  // 条件渲染会销毁和重新创建组件，组件状态将不会保留。
  @State
  count: number = 0

  build() {
    Text(this.count.toString())
      .onClick(() => {
        this.count ++
      })
  }
}