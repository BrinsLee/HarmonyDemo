/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 1）对象类型状态
 */
class User {
  nickname: string = ""
  age: number = 0
}

class UserData {
  code: number = 0
  message: string = ""
  // 嵌套对象
  data: User = new User()
}

@Entry
@Component
struct ComplexPage {
  @State user: User = { nickname: 'jack', age: 18 }

  //  使用 class 来约束对象类型，和嵌套对象和对象数组。
  // 嵌套对象和对象数组，采用赋值的方式进行更新，可以更新UI。
  @State
  res: UserData = {
    code: 10000,
    message: '获取用户信息成功',
    // 嵌套对象
    data: { nickname: 'jack', age: 18 }
  }

  build() {
    Column({space: 20}) {
      Text(this.user.nickname)
      Text(this.user.age.toString())
      Divider()
      Text(this.res.data.nickname)
      Text(this.res.data.age.toString())
      Button('age++').onClick(() => {
        this.user.age ++

        // 对于嵌套对象
        const user = this.res.data
        // 替换属性，触发UI更新
        this.res.data = { nickname: user.nickname, age: user.age + 1  }
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}