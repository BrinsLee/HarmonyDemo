@Entry
@Component
struct PageTaskList {
  build() {
    Column() {
      Text("你好小李")
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor($r("app.color.text_color"))
      Text("让每天的工作效率提高")
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ top: 10 })
      Text("我的计划")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor($r("app.color.text_color"))
        .margin({ top: 30 })
      Row() {
        Column({ space: 10 }) {
          // 已完成
          Column({ space: 10 }) {
            Image($r("app.media.startIcon")).width(100)
            Text("已完成")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
            Text("0任务")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
          }
          .height(168)
          .width(164)
          .backgroundImage($r("app.media.list1"))
          .backgroundImageSize(ImageSize.Cover)
          .alignItems(HorizontalAlign.Start)
          .borderRadius({
            topLeft: 10,
            topRight: 10,
            bottomLeft: 10,
            bottomRight: 10
          })

          // 等待中
          Column({ space: 10 }) {
            Image($r("app.media.startIcon"))
              .width(100).height(50).objectFit(ImageFit.Contain)
            Text("已完成")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
            Text("0任务")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
          }
          .width(168)
          .height(128)
          .backgroundImage($r("app.media.list2"))
          .backgroundImageSize(ImageSize.Cover)
          .alignItems(HorizontalAlign.Start)
          .borderRadius({
            topLeft: 10,
            topRight: 10,
            bottomLeft: 10,
            bottomRight: 10
          })
        }.width("50%")
        .height("100%")
        .backgroundColor(Color.Red)


        Column() {

        }.width("50%")
        .height("100%")

      }.height(300)
      .width("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f3f5")
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: 10,
      top: 10,
      right: 10,
      bottom: 10
    })
  }
}