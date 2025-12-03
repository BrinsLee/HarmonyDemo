/**
 * @author lipeilin
 * @date 2025/7/2
 * @project MyApplication
 * @description 描述信息
 */

/**
 * @Builder装饰的函数称为 自定义构建函数
 * 严格禁止在其内部定义状态变量或使用生命周期函数
 */
@Entry
@Component
struct BuilderDemo {
  @Builder
  showTextBuilder() {
    Text('hello world')
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
  }

  // 参数默认按值传递，状态变量的改变不会引发ui刷新，推荐使用按引用传递
  @Builder
  showTextValueBuilder(params: string) {
    Text(`值传递，不会更新UI ${params}`)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
  }

  // 按引用传递
  @Builder
  overBuilder(params: Tmp) {
    Row() {
      Text(`UseStateVarByReference: ${params.paramA1} `)
    }
  }
  @State label: string = 'Hello';

  build() {
    Column() {
      // 无参数
      this.showTextBuilder()
      // 有参数
      this.showTextValueBuilder("hello world")

      // 在父组件中调用overBuilder组件时，
      // 把this.label通过引用传递的方式传给overBuilder组件。
      this.showTextValueBuilder(this.label)
      this.overBuilder({ paramA1: this.label })
      Button('Click me').onClick(() => {
        // 单击Click me后，UI文本从Hello更改为ArkUI。
        this.label = 'ArkUI';
      })
      PanelComp({title: '标题', more: '更多'}) {
        Text('传入UI底部')
      }
    }
  }
}

@Component
struct PrivateBuilder {
  @State builder_value: string = 'Hello';


  @Builder
  builder() {
    Column() {
      Text(this.builder_value)
        .width(230)
        .height(40)
        .backgroundColor('#ffeae5e5')
        .borderRadius(20)
        .margin(12)
        .textAlign(TextAlign.Center)
    }
  }


  aboutToAppear(): void {
    setTimeout(() => {
      this.builder_value = 'Hello World';
    }, 2000);
  }


  build() {
    Row() {
      Column() {
        Text(this.builder_value)
          .width(230)
          .height(40)
          .backgroundColor('#ffeae5e5')
          .borderRadius(20)
          .textAlign(TextAlign.Center)
        this.builder()
        Button('点击改变builder_value内容')
          .onClick(() => {
            this.builder_value = 'builder_value被点击了';
          })
      }
      .height('100%')
      .width('100%')
    }
  }
}

class Tmp {
   paramA1: string = '';
}


interface GeneratedTypeLiteralInterface_1 {
  username: string;
}

// 全局自定义构建函数 按引用传参
@Builder
function GlobalBuilder(user: GeneratedTypeLiteralInterface_1 ) {
  Column() {
    Text(`Hello ${user.username}`)
      .fontSize(40)
      .margin(20)
  }
}


// @BuildParam 该装饰器用于声明任意UI描述的一个元素，类似 slot 占位符

@Component
struct PanelComp {
  title?: string
  more?: string

  @BuilderParam
  panelContent: () => void = this.DefaultPanelContent

  // 默认显示内容
  @Builder
  DefaultPanelContent () {
    Text('默认内容')
  }

  build() {
    Column() {
      Row() {
        Text(this.title)
          .layoutWeight(1)
          .fontWeight(600)

        Row() {
          Text(this.more)
            .fontSize(14)
            .fontColor('#666666')
          Image($r('app.media.app_back_black_right_one'))
            .width(6)

        }
      }.padding(10)

      Row() {
        this.panelContent()
      }.height(100)
    }
    .borderRadius(12)
    .backgroundColor('#fff')
  }
}