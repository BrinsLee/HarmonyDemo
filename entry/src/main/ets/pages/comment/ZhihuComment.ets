/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 描述信息
 */
import { it } from '@ohos/hypium'
import { ReplyItem, replyList } from '.'
import { promptAction } from '@kit.ArkUI'
import { text } from '@kit.ArkGraphics2D'

@Entry
@Component
struct ZhihuComment {
  @State
  replayList: ReplyItem[] = replyList

  @State
  content: string = ""

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
            // 回复列表
            Column() {
              Text('回复 100')
                .width('100%')
                .fontWeight(600)
              ForEach(this.replayList, (item: ReplyItem) => {
                Row() {
                  Image(item.avatar)
                    .width(32)
                    .aspectRatio(1)
                    .borderRadius(16)
                  Column({ space: 5 }) {
                    Text(item.author)
                      .width('100%')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(15)
                    Text(item.content)
                      .width('100%')
                    Row() {
                      Text(`${item.time}· IP属地${item.area}`)
                        .fontSize(12)
                        .fontColor('#c3c4c5')
                      Row({ space: 4 }) {
                        Image($r(item.likeFlag ? 'app.media.base_ic_heart_liked' : 'app.media.base_ic_heart_unlike'))
                          .width(14)
                          .height(14)
                          .margin({ right: 4 })
                        Text(item.likeNum.toString())
                          .fontSize(12)
                          .fontColor(item.likeFlag ? '#ff6600' : '#c3c4c5')
                      }.onClick(() => {
                        this.onLike(item)
                      })
                    }.width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                  }
                  .layoutWeight(1)
                  .padding({ left: 10 })
                }
                .padding({ top: 15, bottom: 15 })
                .alignItems(VerticalAlign.Top)
              })
            }
            .padding(15)
          }
          .padding({ bottom: 50 })
        }
      }
      .width('100%')
      .height('100%')

      Row({ space: 15 }) {
        TextInput({ placeholder: '回复~' , text: this.content})
          .placeholderColor('#c3c4c5')
          .layoutWeight(1)
          .onChange((value) => {
            this.content = value
          })
        Text('发布').fontColor('#069')
          .onClick(() => {
            this.onReply()
          })
      }
      .padding({ left: 15, right: 15 })
      .width('100%')
      .height(50)
      .backgroundColor('#fff')
      .border({ width: { top: 0.5 }, color: '#e4e4e4' })
    }
  }

  onLike(item: ReplyItem) {
    const reply: ReplyItem = {
      id: item.id,
      avatar: item.avatar,
      author: item.author,
      content: item.content,
      time: item.time,
      area: item.area,
      likeNum: item.likeNum,
      likeFlag: item.likeFlag
    }
    if (reply.likeFlag) {
      reply.likeNum--
      reply.likeFlag = false
      promptAction.showToast({ message: '取消点赞' })
    } else {
      reply.likeNum++
      reply.likeFlag = true
      promptAction.showToast({ message: '点赞成功' })
    }
    const index = this.replayList.findIndex(rep => rep.id === reply.id)
    this.replayList[index] = reply
  }

  onReply() {
    const reply: ReplyItem = {
      id: Math.random(),
      content: this.content,
      author: 'Zhousg',
      avatar: $r('app.media.icecream'),
      time: '12-01',
      likeNum: 0,
      area: '北京'
    }
    this.replayList.unshift(reply)
    this.content = ''
    promptAction.showToast({ message: '回复成功' })

  }
}

// 导航 spread
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
      .onClick(() => {
        this.getUIContext().getRouter().back()
      })

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
    Column() {
      Text('回复 100')
        .width('100%')
        .fontWeight(600)
      ForEach([1, 2, 3, 4, 5, 6, 7], () => {
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
          }.layoutWeight(1)
          .padding({ left: 10 })
        }
        .padding({ top: 15, bottom: 15 })
        .alignItems(VerticalAlign.Top)
      })
    }.padding(15)
  }
}

