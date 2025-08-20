import { AbilityConstant, UIAbility, Want } from "@kit.AbilityKit";
import Logger from "../utils/Logger";
import { window } from "@kit.ArkUI";
import { Data } from "../model/DataModels";

/**
 * @author lipeilin
 * @date 2025/8/19
 * @project demo
 * @description 描述信息
 */
const TAG = '[Sample_StartMode]';

export default class MultitonAbility extends UIAbility {
  getAbilityDataCallback: Function | undefined = undefined;

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    super.onCreate(want, launchParam);
    const that = this;
    this.context.eventHub.on('getAbilityData', this.getAbilityDataCallback = (data: Data): void => {
      Logger.info(TAG, 'MainAbility' + JSON.stringify(data));
      data.context = that.context;
      data.launchWant = want;
    })
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info(TAG, 'MultitonAbility onWindowStageCreate');

    windowStage.loadContent('pages/FoodDetail', (err, data) => {
      if (err.code) {
        Logger.info(TAG, 'Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      Logger.info(TAG, 'Succeeded in loading the content. Data: ' + JSON.stringify(data));
    })
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    Logger.info(TAG, 'MultitonAbility onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    Logger.info(TAG, 'MultitonAbility onForeground');
  }

  onBackground() {
    // Ability has back to background
    Logger.info(TAG, 'MultitonAbility onBackground');
  }
}