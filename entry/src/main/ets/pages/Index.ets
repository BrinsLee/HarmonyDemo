import { url } from '@kit.ArkTS';
import { common, Want } from '@kit.AbilityKit';
import Logger from '../utils/Logger';
import { startMode } from '../utils/Util';
import Constants from '../common/Constants';

// 装饰的自定义组件作为UI页面的入口，在单UI页面中，最多可以使用@Entry装饰一个自定义组件
//
@Entry
  // @Component 装饰器代表自定义组件，用@Component装饰的结构体是可重用的UI单元
@Component
struct Index {
  // 表示组件中的状态变量，状态变量的变化会触发UI刷新
  @State message: string = 'Hello World';

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  // onPageShow 页面每次显示时触发
  onPageShow(): void {
    console.info('index onPageShow')
  }

  // onPageHide 页面每次隐藏时触发
  onPageHide(): void {
    console.info('Index onPageHide')
  }

  // onBackPress 用户点击返回时触发
  onBackPress() {
    console.info('Index onBackPress');
    // 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
    return true;
  }

  // 组件生命周期
  // aboutToAppear 组件即将出现时回调该接口，具体时机是在创建自定义组件的新实例后，执行build之前执行
  aboutToAppear() {
    console.info('MyComponent aboutToAppear');
  }

  // 组件生命周期
  //
  onDidBuild() {
    console.info('MyComponent onDidBuild');
  }

  // 组件生命周期
  // aboutToDisappear 在自定义组件即将析构销毁时执行
  aboutToDisappear() {
    console.info('MyComponent aboutToDisappear');
  }

  @State
  activeIndex: number = 0
  toolBars: ToolBarItem[] = [
    {
      defaultIcon: $r('app.media.ui7_home_page_bt_home_uncheck'),
      activeIcon: $r('app.media.ui7_home_page_bt_home_check'),
      label: '首页'
    },
    {
      defaultIcon: $r('app.media.ui7_home_page_bt_dynamic_uncheck'),
      activeIcon: $r('app.media.ui7_home_page_bt_dynamic_check'),
      label: '项目'
    },
    {
      defaultIcon: $r('app.media.ui7_home_page_bt_video_uncheck'),
      activeIcon: $r('app.media.ui7_home_page_bt_video_check'),
      label: '面经'
    },
    {
      defaultIcon: $r('app.media.ui7_home_page_bt_mine_uncheck'),
      activeIcon: $r('app.media.ui7_home_page_bt_mine_check'),
      label: '我的'
    }
  ]

  // 可以使用@Builder/@BuilderParam 特殊封装UI描述方法，细粒度封装和复用UI描述
  // @Extend/@Style 扩展内置组件和封装属性样式，更灵活地组合内置组件
  @Builder
  TabBarBuilder(item: ToolBarItem, index: number) {
    Column() {
      Column() {
        Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
          .width(24)
        Text(item.label)
          .fontSize(12)
          .margin({ top: 4 })
          .lineHeight(12)
          .fontColor(this.activeIndex === index ? '#FA3453' : '#aaa')
      }
    }
  }

  build() {
    Tabs({
      index: this.activeIndex
    }) {
      ForEach(this.toolBars, (item: ToolBarItem, index: number) => {
        TabContent() {
          if (index == 0) {
            Scroll() {
              Column({ space: 10 }) {
                Button('@Prop')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/statev1/PropPage' })
                  })
                  .width(200)

                Button('@Link')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/statev1/LinkPage' })
                  })
                  .width(200)

                Button('@Provide @Consume')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/statev1/ProvideConsume' })
                  })
                  .width(200)

                Button('@Watch')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/statev1/WatchPage' })
                  })
                  .width(200)

                Button('@Observed @ObjectLink')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/statev1/ObservedObjectLinkPage' })
                  })
                  .width(200)

                Button('自定义组件')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/customcomponent/customComponent' })
                  })
                  .width(200)

                Button('@Builder')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/customcomponent/componentExtend' })
                  })
                  .width(200)

                Button('todolist')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/PageTaskList' })
                  })
                  .width(200)

                Button('启动页面Singleton')
                  .onClick(() => {
                    startMode({}, 'FoodMainAbility')
                  })
                  .width(200)

                Button('启动相机')
                  .onClick(() => {
                    startMode({}, 'CameraAbility')
                  })
                  .width(200)

                Button('复杂状态')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/ComplexState' })
                  })
                  .width(200)
                Button('界面渲染')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/RenderPage' })
                  })
                  .width(200)

                Button('知乎')
                  .onClick(() => {
                    this.getUIContext().getRouter().pushUrl({ url: 'pages/comment/ZhihuComment' })
                  })
                  .width(200)

              }.width('100%')
              .alignItems(HorizontalAlign.Center)

            }
            .height(Constants.FULL_PERCENT)
            .width(Constants.FULL_PERCENT)
          } else {
            Text(item.label)
          }
        }.tabBar(this.TabBarBuilder(item, index))
      })
    }
    .barPosition(BarPosition.End)
    .onChange(index => this.activeIndex = index)
  }
}


interface ToolBarItem {
  defaultIcon: string | Resource
  activeIcon: string | Resource
  label: string
}