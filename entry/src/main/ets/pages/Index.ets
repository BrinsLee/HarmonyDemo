import { url } from '@kit.ArkTS';
import { common, Want } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow(): void {
    console.info('index onPageShow')
  }

  onPageHide(): void {
    console.info('Index onPageHide')
  }

  onBackPress() {
    console.info('Index onBackPress');
    // 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
    return true;
  }

  // 组件生命周期
  aboutToAppear() {
    console.info('MyComponent aboutToAppear');
  }

  // 组件生命周期
  onDidBuild() {
    console.info('MyComponent onDidBuild');
  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('MyComponent aboutToDisappear');
  }

  build() {
    RelativeContainer() {
      Column({space:10}){
        Button('@Prop')
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: 'pages/statev1/propV1'})
          })
          .width(200)

        Button('自定义组件')
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: 'pages/customcomponent/customComponent'})
          })
          .width(200)

        Button('@Builder')
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: 'pages/customcomponent/componentExtend'})
          })
          .width(200)

        Button('todolist')
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: 'pages/PageTaskList'})
          })
          .width(200)

        Button('启动页面Singleton')
          .onClick(()=>{
            let context: common.UIAbilityContext =
              this.getUIContext().getHostContext() as common.UIAbilityContext;
            let want: Want = {
              bundleName: 'com.example.myapplication',
              abilityName: 'SingletonAbility',
              parameters: {
                name: 'Singleton'
              }
            }

            context.startAbility(want, (err) => {})
          })
          .width(200)

      }.width('100%')
      .alignItems(HorizontalAlign.Center)

    }
    .height('100%')
    .width('100%')
  }
}