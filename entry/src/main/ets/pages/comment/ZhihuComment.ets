/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 描述信息
 */

@Entry
@Component
struct ZhihuComment {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            // 导航
            NavComp()
            // 评论
            CommentComp()
            // 分割线
            Divider().strokeWidth(8).color('#f5f5f5')
          }
          .padding({ bottom: 5 })
        }
      }
      .width('100%')
      .height('100%')

      Row({ space: 15 }) {
        TextInput({ placeholder: '回复~' }).layoutWeight(1)
        Text('发布').fontColor('#069')
      }
      .padding({ left: 15, right: 15 })
      .width('100%')
      .height(50)
      .backgroundColor('#fff')
      .border({width: {top:0.5}, color: '#e4e4e4'})
    }
  }

}

// 导航
@Component
struct NavComp {
  build() {
    Row() {
      Row() {
        Image($r('app.media.back'))
          .width(16)
          .aspectRatio(1)
        // svg 图标可以使用填充颜色
        // .fillColor('red')
      }
      .width(24)
      .aspectRatio(1)
      .backgroundColor('#f5f5f5')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .margin({ left: 16 })

      Text('评论回复')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .padding({ right: 40 })
    }
    .height(40)
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  }
}

// 评论
@Component
struct CommentComp {
  build() {
    Row() {
      Image($r('app.media.blueberry'))
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)
      Column({ space: 5 }) {
        Text('周杰伦')
          .width('100%')
          .fontWeight(FontWeight.Bold)
          .fontSize(15)
        Text('大理石能雕刻出肌肉和皮肤的质感，那个年代的工匠好牛啊')
          .width('100%')
        Row() {
          Text('10-21 · IP属地北京')
            .fontSize(12)
            .fontColor('#c3c4c5')
          Row({ space: 4 }) {
            Image($r('app.media.crab'))
              .width(14)
              .aspectRatio(1)
              .fillColor('#c3c4c5')
            Text('100')
              .fontSize(12)
              .fontColor('#c3c4c5')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .padding({ left: 10 })
    }
    .padding(15)
    .alignItems(VerticalAlign.Top)
  }
}

