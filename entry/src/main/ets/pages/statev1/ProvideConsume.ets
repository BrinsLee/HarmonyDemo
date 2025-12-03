/**
 * @author lipeilin
 * @date 2025/12/2
 * @project demo
 * @description 描述信息
 */
import { Person } from './LinkPage'

// @Provide 和 @Consume，应用于与后代组件的双向数据同步，应用于状态数据在"多个层级"之间传递的场景。
@Entry
@Component
struct Index {

  // 简单类型 string number boolean enum
  @Provide
  money: number = 0

  // 复杂类型
  @Provide
  person: Person = {name: 'jack', age: 18}

  build() {
    Column({ space: 20 }){
      Text('简单类型')
      Text('爷组件：' + this.money)
        .onClick(() => {
          this.money ++
        })
      Parent()
      Divider()
      Text('复杂类型')
      Text('爷组件：' + `${this.person.name} 今年 ${ this.person.age } 岁`)
        .onClick(() => {
          this.person.age ++
        })
      // @Link 属于引用传递，必须使用$传递引用
     Parent()
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Parent {
  @Consume
  money: number
  @Consume
  person: Person

  build() {
    Column({ space: 20 }) {
      Text('父组件：' + this.money)
        .onClick(() => {
          this.money++
        })
      Child()
    }
  }
}

@Component
struct Child {
  @Consume
  money: number
  @Consume
  person: Person

  build() {
    Column() {
      Text('子组件：' + this.money)
        .onClick(() => {
          this.money ++
        })
      Text('子组件：' +  `${this.person.name} 今年 ${ this.person.age } 岁`)
        .onClick(() => {
          this.person.age ++
        })
    }

  }
}

