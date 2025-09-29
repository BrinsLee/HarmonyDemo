/**
 * @author lipeilin
 * @date 2025/8/20
 * @project demo
 * @description 描述信息
 */
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import window from '@ohos.window';
import Logger from '../utils/Logger';

const TAG = '[Sample_Camera]';

export default class  CameraAbility extends UIAbility {

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    super.onCreate(want, launchParam);
  }

  onDestroy(): void | Promise<void> {

  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/CameraPage', (err, data) => {
      if (err.code) {
        Logger.info(TAG, 'Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      Logger.info(TAG, 'Succeeded in loading the content. Data: ' + JSON.stringify(data));
    })
  }

}