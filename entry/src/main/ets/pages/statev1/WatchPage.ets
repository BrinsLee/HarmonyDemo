/**
 * @author lipeilin
 * @date 2025/12/2
 * @project demo
 * @description 状态共享-状态监听器
 */
import { promptAction } from '@kit.ArkUI'

//如果开发者需要关注某个状态变量的值是否改变，可以使用 @Watch 为状态变量设置回调函数。
@Entry
@Component
struct WatchIndex {
  @State activeIndex: number = 0

  onChange(index: number) {
    this.activeIndex = index
    promptAction.showToast({ message: '点击' })
  }

  build() {
    Navigation() {
      Child({ activeIndex: this.activeIndex })
    }.toolbarConfiguration([
      { value: '首页', action: () => this.onChange(0) },
      { value: '我的', action: () => this.onChange(1)}
    ])
  }
}


@Component
struct Child {
  // 在第一次初始化的时候，@Watch装饰的方法不会被调用
  @Prop
  @Watch('onActiveIndex')
  activeIndex: number

  onActiveIndex() {
    promptAction.showToast({ message: `监听变化${this.activeIndex}` })
  }

  build() {
    Column() {
      Text('Child' + this.activeIndex)
    }
  }
}

