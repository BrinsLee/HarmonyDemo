/**
 * @author lipeilin
 * @date 2025/6/30
 * @project MyApplication
 * @description 描述信息
 */
class Info {
  address: string = '杭州';
}

@Component
struct Test {
  @State message:string = '上海';
  @State info: Info = new Info();

  aboutToAppear(): void {
    this.info.address = this.message;
  }

  build() {
    Column() {
      Text(`${this.message}`);
      Text(`${this.info.address}`);
      Button('change')
        .onClick(() => {
          this.info.address = '北京';
        })
    }
  }
}

// 示例2
class Info2 {
  address: string = '杭州';

  constructor(address: string) {
    this.address = address;
  }
}

class User {
  info: Info = new Info2('天津');
}

@Entry
@Component
struct Test2 {
  @State info: Info = new Info2('上海');
  @State user: User = new User();

  aboutToAppear(): void {
    this.user.info = this.info;
  }

  build() {
    Column() {
      Text(`${this.info.address}`);
      Text(`${this.user.info.address}`);
      Button('change')
        .onClick(() => {
          this.user.info.address = '北京';
        })
    }
  }
}