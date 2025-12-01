/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 描述信息
 */

@Extend(Text)
function myClick(color: string, callback: () => void) {
  .backgroundColor(color)
  .width(100)
  .height(50)
  .textAlign(TextAlign.Center)
  .borderRadius(25)
  .onClick(() => callback())
}