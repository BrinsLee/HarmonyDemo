import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import Logger from '../utils/Logger';

const TAG = '[Sample_StartMode]';

interface Data {
  context: Context;
  launchWant: Want;
}

export default class FoodMainAbility extends UIAbility {
  getAbilityDataCallback: Function | undefined = undefined;

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Logger.info(TAG, 'MainAbility onCreate');
    this.context.eventHub.on('getAbilityData', this.getAbilityDataCallback = (data: Data) => {
      Logger.info(TAG, `getAbilityData: ${JSON.stringify(data)}`);
      data.context = this.context;
      data.launchWant = want;
    })
  }

  onDestroy(): void {
    Logger.info(TAG, 'MainAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    Logger.info(TAG, 'MainAbility onWindowStageCreate');

    windowStage.loadContent('pages/FoodMain', (err, data) => {
      if (err.code) {
        Logger.info(TAG, 'Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      Logger.info(TAG, 'Succeeded in loading the content. Data: ' + JSON.stringify(data));
    })
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info(TAG, 'MainAbility onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info(TAG, 'MainAbility onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info(TAG, 'MainAbility onBackground');
  }
}
