/**
 * @author lipeilin
 * @date 2025/12/1
 * @project demo
 * @description 界面渲染
 */

class UserDataBean {
  id: string = ""
  name: string = ""
  age: number = 0
}

@Entry
@Component
struct Index {

  @State
  show: boolean = true
  @State
  userList: UserDataBean[] = []

  build() {
    Scroll() {
      Column({ space: 20 }){
        // 条件渲染
        if (this.show) {
          // 累计的 count 切换时候不会保留
          CounterComp()
        }
        Button('toggle')
          .onClick(() => {
            this.show = !this.show
          })

        // 循环渲染
        // 关于KeyGenerator
        // 1、不能缺省
        // 2、避免最终生成的键包含 index
        // 3、对象数组建议使用id作为唯一标识
        // 4、基本数据，建议转换成具有id唯一标识的对象，再使用
        ForEach(
          // 1. 数据源
          this.userList,
          // 2. 组件生成函数
          (item: UserDataBean) => {
            // 内容
            Text(`${item.name} 今年 ${item.age} 岁`)
          },
          (item: UserDataBean) => {
            return item.id
          }
        )
        Button('加载更多')
          .onClick(() => {
            const arr: UserDataBean[] = []
            for (let index = 0; index < 10; index++) {
              arr.push({ id: Math.random().toString(), name: 'jack', age: Math.ceil(Math.random() * 100) })
            }
            this.userList.push(...arr)
          })

      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CounterComp {
  // 条件渲染会销毁和重新创建组件，组件状态将不会保留。
  @State
  count: number = 0

  build() {
    Text(this.count.toString())
      .onClick(() => {
        this.count ++
      })
  }
}

