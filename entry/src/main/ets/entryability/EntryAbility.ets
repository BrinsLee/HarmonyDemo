import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { Data } from '../model/DataModels';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  getAbilityDataCallback: Function | undefined = undefined;

  windowStage: window.WindowStage | undefined = undefined;
  /**
   * 页面初始化，首次创建回调，UIAbility整个生命周期中仅发生一次
   * @param want 相当于Intent
   * @param launchParam
   */
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
    this.context.eventHub.on('getAbilityData', this.getAbilityDataCallback = (data: Data) => {
      data.context = this.context;
      data.launchWant = want;
    })
  }

  /**
   * WindowStage 回调，
   * UIAbility实例创建完成之后，在进入前台之前，系统会创建一个WindowStage。WindowStage创建完成后会进入onWindowStageCreate()回调
   * @param windowStage
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    this.windowStage = windowStage;
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
    try {
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            hilog.info(DOMAIN, 'testTag', `windowStage foreground.`);
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            hilog.info(DOMAIN, 'testTag', `windowStage active.`);
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            hilog.info(DOMAIN, 'testTag', `windowStage inactive.`);
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            hilog.info(DOMAIN, 'testTag', `windowStage background.`);
            break;
          case window.WindowStageEventType.RESUMED: // 前台可交互状态
            hilog.info(DOMAIN, 'testTag', `windowStage resumed.`);
            break;
          case window.WindowStageEventType.PAUSED: // 前台不可交互状态
            hilog.info(DOMAIN, 'testTag', `windowStage paused.`);
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      hilog.error(DOMAIN, 'testTag',
        `Failed to enable the listener for window stage event changes. Cause: ${JSON.stringify(exception)}`);
    }
  }


  /**
   * 当应用的UIAbility实例已创建，再次调用方法启动该UIAbility实例时，系统触发该UIAbility的onNewWant()回调。
   * @param want
   * @param launchParam
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    super.onNewWant(want, launchParam);
  }

  /**
   * 在UIAbility切换至前台时且UIAbility的UI可见之前，系统触发onForeground回调。
   * 开发者可以在该回调中申请系统需要的资源，或者重新申请在onBackground()中释放的资源。
   * 系统回调该方法后，UIAbility实例进入前台状态，即UIAbility实例可以与用户交互的状态。
   */
  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }


  /**
   * 在UIAbility的UI完全不可见之后，系统触发onBackground回调，将UIAbility实例切换至后台状态。
   * 开发者可以在该回调中释放UI不可见时的无用资源
   */
  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }

  /**
   * WindowStage 回调
   * 在UIAbility实例销毁之前，系统触发onWindowStageWillDestroy()回调。
   * 该回调在WindowStage销毁前执行，此时WindowStage可以使用。
   * 开发者可以在该回调中释放通过WindowStage获取的资源、注销WindowStage事件订阅等。
   */
  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    try {
      if (this.windowStage) {
        this.windowStage.off('windowStageEvent');
      }
    }catch (e) {
      
    }
    super.onWindowStageWillDestroy(windowStage);
  }

  /**
   * WindowStage 回调
   * 在UIAbility实例销毁之前，系统触发onWindowStageDestroy()回调，开发者可以在该回调中释放UI资源。
   * 该回调在WindowStage销毁后执行，此时WindowStage不可以使用。
   */
  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }


  /**
   * 在UIAbility实例销毁之前，系统触发onDestroy回调。
   * 该回调是UIAbility接收到的最后一个生命周期回调，开发者可以在onDestroy()回调中进行系统资源的释放、数据的保存等操作。
   */
  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }
}