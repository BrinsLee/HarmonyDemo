/**
 * @author lipeilin
 * @date 2025/12/2
 * @project demo
 * @description 描述信息
 */
// 子组件中被@Link装饰的变量与其父组件中对应的数据源建立双向数据绑定。
@Entry
@Component
struct LinkV1 {

  // 简单类型 string number boolean enum
  @State
  money: number = 0

  // 复杂类型
  @State
  person: Person = {name: 'jack', age: 18}

  build() {
    Column({ space: 20 }){
      Text('简单类型')
      Text('父组件：' + this.money)
        .onClick(() => {
          this.money ++
        })
      Child({ money: $money, person: $person })
      Divider()
      Text('复杂类型')
      Text('父组件：' + `${this.person.name} 今年 ${ this.person.age } 岁`)
        .onClick(() => {
          this.person.age ++
        })
      // @Link 属于引用传递，必须使用$传递引用
      Child({ money:$money, person: $person })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Child {
  @Link
  money: number
  @Link
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

export interface  Person {
  name: string
  age: number
}