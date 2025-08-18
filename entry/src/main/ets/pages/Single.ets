/**
 * @author lipeilin
 * @date 2025/8/18
 * @project MyApplication
 * @description 描述信息
 */

@Entry
@Component
struct Single {

  @LocalStorageLink('params') params: Record<string, Object> =  {}; // 接收参数

  aboutToAppear(): void {
    console.info('Single aboutToAppear')
    console.info('params:', this.params)
  }

  build() {
    Column() {
      Text(`${this.params['name']}`).fontSize(30).fontColor(Color.Black)
    }.margin(20)
  }
}