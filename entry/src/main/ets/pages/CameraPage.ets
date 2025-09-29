/**
 * @author lipeilin
 * @date 2025/8/20
 * @project demo
 * @description 描述信息
 */
import { camera, cameraPicker } from '@kit.CameraKit';
import Constants from '../common/Constants';
import Logger from '../utils/Logger';
import { Context } from '@kit.AbilityKit';

@Entry
@Component
struct CameraPage {
  @State uri: Resource | string | undefined = undefined;
  private cameraPosition: Array<camera.CameraPosition> = [
    camera.CameraPosition.CAMERA_POSITION_UNSPECIFIED, camera.CameraPosition.CAMERA_POSITION_BACK,
    camera.CameraPosition.CAMERA_POSITION_FRONT
  ];
  private mediaType: Array<cameraPicker.PickerMediaType> = [
    cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO
  ];
  private context : Context|undefined = this.getUIContext().getHostContext()

  build() {
    Row() {
      Column() {
        Image(this.uri)
          .height($r('app.float.image_height'))
          .alt($r('app.media.foreground'))

        Button($r('app.string.capture'))
          .width($r('app.float.button_width'))
          .margin({top: $r('app.float.margin')})
          .clickEffect({level: ClickEffectLevel.MIDDLE, scale: 0.8})
          .onClick(async () => {
            try {
              let pickerProfile: cameraPicker.PickerProfile = {
                cameraPosition: this.cameraPosition[1]
              }
              let pickerResult: cameraPicker.PickerResult = await cameraPicker.pick(this.context,[this.mediaType[0]], pickerProfile)
              this.uri = pickerResult.resultUri;
            }catch (e) {
              Logger.error("CameraPage", e)
            }
          })

      }.width(Constants.FULL_PERCENT)
    }.height(Constants.FULL_PERCENT);
  }
}