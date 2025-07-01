import { UIUtils } from '@kit.ArkUI';

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
  info: Info2 = new Info2('天津');
}

@Component
struct Test2 {
  @State info: Info2 = new Info2('上海');
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

// 示例3
// 首先执行this.user.info = new Info('广州')，
// 会创建一个新的Info对象。再执行this.user.info.address = '北京'，
// 改变的是这个新创建的Info对象中的address值，而原始的Info对象中的address值不会受到影响。
@Component
struct Test3 {
  @State info: Info2 = new Info2('上海');
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
          this.user.info = new Info2("广州");
          this.user.info.address = '北京';
        })
    }
  }
}

// 复杂类型常量重复赋值给状态变量触发刷新
// 状态管理V1中，会给被@Observed装饰的类对象以及使用状态变量装饰器如@State装饰的
// Class、Date、Map、Set、Array类型的对象添加一层代理用于观测一层属性或API调用产生的变化。
// 方法一：添加@Observed 避免重复刷新
// 方法二：使用UIUtils.getTarget()获取原始对象
@Observed
class DataObj {
  name: string = 'default name';

  constructor(name: string) {
    this.name = name;
  }
}

@Component
struct Index {
  list: DataObj[] = [new DataObj('a'), new DataObj('b'), new DataObj('c')];
  @State dataObjFromList: DataObj = this.list[0];

  build() {
    Column() {
      ConsumerChild({ dataObj: this.dataObjFromList })
      Button('change to self').onClick(() => {
        // 当再次赋值list[0]时，dataObjFromList已经是Proxy类型，
        // 而list[0]是Object类型，因此判断两者不相等，会触发赋值和刷新。
        this.dataObjFromList = this.list[0];

        // 使用UIUtils.getTarget()获取原始对象进行判断
        /*if (UIUtils.getTarget(this.dataObjFromList) !== this.list[0]) {
          this.dataObjFromList = this.list[0];
        }*/
      })
    }
  }
}

@Component
struct ConsumerChild {
  @Link @Watch('onDataObjChange') dataObj: DataObj;

  onDataObjChange() {
    console.log("dataObj changed");
  }

  getContent() {
    console.log(`this.dataObj.name change: ${this.dataObj.name}`);
    return this.dataObj.name;
  }

  build() {
    Column() {
      Text(this.getContent()).fontSize(30)
    }
  }
}

class Balloon {
  volume: number;
  constructor(volume: number) {
    this.volume = volume;
  }


  static increaseVolume(balloon:Balloon) {
    balloon.volume += 2;
  }
}


@Component
struct Index2 {
  @State balloon: Balloon = new Balloon(10);


  reduceVolume(balloon:Balloon) {
    balloon.volume -= 1;
  }


  build() {
    Column({space:8}) {
      Text(`The volume of the balloon is ${this.balloon.volume} cubic centimeters.`)
        .fontSize(30)
      Button(`increaseVolume`)
        .onClick(()=>{
          // 通过静态方法调用，无法触发UI刷新
          // Balloon.increaseVolume(this.balloon);
          // 通过赋值给临时变量保留Proxy代理
          let balloon1 = this.balloon;
          Balloon.increaseVolume(balloon1);
        })
      Button(`reduceVolume`)
        .onClick(()=>{
          // 使用this通过自定义组件内部方法调用，无法触发UI刷新
          // this.reduceVolume(this.balloon);
          // 通过赋值给临时变量保留Proxy代理
          let balloon2 = this.balloon;
          this.reduceVolume(balloon2);
        })
    }
    .width('100%')
    .height('100%')
  }
}


// 示例
class Model {
  private callback: (() => void) | undefined = () => {};


  add(callback: () => void): void {
    this.callback = callback;
  }


  delete(): void {
    this.callback = undefined;
  }


  call(): void {
    if (this.callback) {
      this.callback();
    }
  }
}


let model: Model = new Model();


@Entry
@Component
struct Test4 {
  @State count: number = 10;


  aboutToAppear(): void {
    model.add(() => {
      this.count++;
    })
  }


  build() {
    Column() {
      Text(`count值: ${this.count}`)
      Button('change')
        .onClick(() => {
          model.call();
        })
    }
  }


  aboutToDisappear(): void {
    model.delete();
  }
}