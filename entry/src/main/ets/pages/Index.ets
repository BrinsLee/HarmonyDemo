import { url } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Column({space:10}){
        Button('@Prop')
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: 'pages/statev1/propV1'})
          })
          .width(200)
      }.width('100%')
      .alignItems(HorizontalAlign.Center)
      /*Column({space:10}){
        TextInput({
          placeholder: "请输入用户名"
        })
        TextInput({
          placeholder: "请输入密码"
        }).type(InputType.NUMBER_PASSWORD)

        Button('登录').width(200)
      }*/
    }
    .height('100%')
    .width('100%')
  }
}