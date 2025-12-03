/**
 * @author lipeilin
 * @date 2025/12/2
 * @project demo
 * @description （包括@State、@Prop、@Link、@Provide和@Consume装饰器）仅能观察到第一层的变化，
 * 但是在实际应用开发中，应用会根据开发需要，封装自己的数据模型。对于多层嵌套的情况,为了实现对嵌套数据结构中深层属性变化的观察，引入了@Observed和@ObjectLink装饰器。
 *
 * @ObjectLink和@Observed类装饰器用于嵌套对象或数组的场景中进行双向数据同步：
 * @Observed：给 类 打标 ——「这个类的实例属性变化要被 UI 追踪」 可观察的模型类
 * @ObjectLink：给 子组件里的变量 打标 ——「这个变量指向父组件里的某个 @Observed 对象，两边属性改了要双向同步」
 * 一般是 组合使用：@Observed + @ObjectLink 来解决「嵌套对象 / 数组项」的联动更新问题。
 *
 */

// 只能装饰 class，不能装饰 interface / type
@Observed
export class TodoItem {
  id: number = 0;
  title: string = "";
  done: boolean = false

  // 必须声明构造函数
  constructor(id: number, title: string, done: boolean = false) {
    this.id = id;
    this.title = title;
    this.done = done;
  }
}

@Component
struct TodoItemView {
  /**
   * 1、装饰的变量类型 必须是被 @Observed 装饰的 class 类型
   * 2、不支持简单类型
   * 3、变量本身不能重新赋值，只能改变其内部属性
   * 4、不能写默认值
   * 5、父组件传入必须是由某个装饰器装饰（@State/@Link/@Prop/@StorageLink/@Provide/@Consume等）
   */
  @ObjectLink
  todo: TodoItem

  build() {
    Row() {
      Checkbox({ name: "done", group: "todos" }).onChange((value: boolean) => {
        this.todo.done = value;
      })
      Text(this.todo.title)
        .margin({ left: 8 })
        .decoration({
          type: this.todo.done ? TextDecorationType.LineThrough : TextDecorationType.None
        })
    }
    .padding(8)
  }
}

@Entry
@Component
struct TodoListPage {
  @State todos: TodoItem[] = [
    new TodoItem(1, '学习 ArkTS 状态管理'),
    new TodoItem(2, '写一个 HarmonyOS NEXT Demo'),
    new TodoItem(3, '休息一下 😄'),
  ];
  // @State 只能观测第一层属性变化，不能观测“嵌套属性”的赋值
  @State profile: UserProfile = new UserProfile('Brin', 'brin@example.com');

  build() {
    Column() {
      ForEach(this.todos, (item: TodoItem) => {
        // 注意这里直接传 item，类型是 TodoItem（已 @Observed）
        TodoItemView({ todo: item })
      }, (item: TodoItem) => item.id.toString())
      // 显示基础资料
      Text(`姓名：${this.profile.name}`).fontSize(20)
      Text(`邮箱：${this.profile.email}`).fontSize(16).margin({ bottom: 16 })

      // 把嵌套的 settings 丢给子组件，建立 @ObjectLink
      ProfileView({ profile: this.profile })
      // 下面这个 Text 会随着 settings 的变化重新渲染
      Text(`父组件@State 当前设置,不会刷新UI：push=${this.profile.settings.pushEnabled}, email=${this.profile.settings.emailEnabled}`)
        .margin({ top: 16 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
  }
}


// 嵌套可观察类
@Observed
export class UserSettings {
  pushEnabled: boolean = true;
  emailEnabled: boolean = false;
}

@Observed
export class UserProfile {
  name: string = '';
  email: string = '';
  settings: UserSettings = new UserSettings(); // 嵌套 Observed

  constructor(name: string, email: string) {
    this.name = name;
    this.email = email;
    this.settings = new UserSettings();
  }
}

@Component
export struct ProfileView {
  @ObjectLink
  profile: UserProfile;   // 这里可以用 @ObjectLink，因为不是 @Entry

  build() {
    Column() {
      // 这里的 Text 就跟着 profile.settings 变化一起刷新了
      Text(`父组件当前设置 会刷新UI：push=${this.profile.settings.pushEnabled}, email=${this.profile.settings.emailEnabled}`)
        .margin({ top: 16 })
      SettingsPanel({ settings: this.profile.settings })

    }
  }
}

// 子组件只关心嵌套的settings
@Component
export struct SettingsPanel {
  @ObjectLink
  settings: UserSettings;

  build() {
    Column() {
      Row() {
        Text("推送通知")
        Toggle({ type: ToggleType.Switch, isOn: this.settings.pushEnabled })
          .onChange((isOn: boolean) => {
            this.settings.pushEnabled = isOn
          })
      }.padding(8)

      Row() {
        Text("邮件通知")
        Toggle({ type: ToggleType.Switch, isOn: this.settings.emailEnabled })
          .onChange((isOn: boolean) => {
            this.settings.emailEnabled = isOn
          })
      }.padding(8)

      Text(`子组件当前设置：push=${this.settings.pushEnabled}, email=${this.settings.emailEnabled}`)
        .margin({ top: 16 })
    }
  }
}