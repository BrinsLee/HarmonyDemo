/**
 * @author lipeilin
 * @date 2025/8/19
 * @project demo
 * @description 描述信息
 */
import { AbilityConstant, AbilityStage, EnvironmentCallback, Want } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    // 应用HAP首次加载时触发，可以在此执行该Module的初始化操作（例如资源预加载、线程创建等）。
    console.log('MyAbilityStage onCreate')
    let envCallback: EnvironmentCallback = {
      onConfigurationUpdated(config) {
        console.info(`envCallback onConfigurationUpdated success: ${JSON.stringify(config)}`);
        let language = config.language; //应用程序的当前语言
        let colorMode = config.colorMode; //深浅色模式
        let direction = config.direction; //屏幕方向
        let fontSizeScale = config.fontSizeScale; //字体大小缩放比例
        let fontWeightScale = config.fontWeightScale; //字体粗细缩放比例
      },
      onMemoryLevel(level) {
        console.log(`onMemoryLevel level: ${level}`);
      }
    };
    try {
      let applicationContext = this.context.getApplicationContext();
      let callbackId = applicationContext.on('environment', envCallback);
      console.log(`callbackId: ${callbackId}`);
    } catch (paramError) {
      console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
    }
  }

  /**
   * UIAbility 指定为 specified模式时启动时候触发事件回调
   * @param want
   * @returns
   */
  onAcceptWant(want: Want): string {
    return super.onAcceptWant(want);
  }

  /**
   * 当系统环境变量（例如系统语言、深浅色等）发生变更时触发的事件回调
   * @param newConfig
   */
/*  onConfigurationUpdate(newConfig: Configuration): void {
    console.log('Configuration updated:', newConfig.fontScale);
  }*/

  /**
   * 当内存空间不足时触发的事件回调
   * @param level
   */
  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    super.onMemoryLevel(level);
  }

  /**
   * UIAbility启动时触发事件回调
   * 开发者可以指定每个UIAbility启动时是否在独立的进程中创建。
   * 该回调返回一个开发者自定义字符串标识，如果返回的字符串标识为开发者曾创建的，则复用该标识所对应的进程，否则创建新的进程。
   * 需要注意该回调需要配合在module.json5中声明isolationProcess字段为true。
   * @param want
   * @returns
   */
  onNewProcessRequest(want: Want): string {
    return super.onNewProcessRequest(want);
  }


  /**
   * 当应用被用户关闭时调用，可用于询问用户选择立即执行操作还是取消操作
   * @returns
   */
  onPrepareTermination(): AbilityConstant.PrepareTermination {
    return super.onPrepareTermination();
  }

  /**
   * 当对应Module的最后一个Ability实例退出后触发。此方法仅在应用正常销毁时触发。
   */
  onDestroy(): void {
    super.onDestroy();
  }
}