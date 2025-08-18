/**
 * @author lipeilin
 * @date 2025/8/15
 * @project MyApplication
 * @description 描述信息
 */

@Component
struct AppBar {
  private title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.white'))
    }
    .backgroundColor('#317bd4')
    .width('100%')
    .height(56)
    .padding({left:20, right: 20})
    .justifyContent(FlexAlign.Center)
  }
}