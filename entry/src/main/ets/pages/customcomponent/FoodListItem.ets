/**
 * @author lipeilin
 * @date 2025/8/18
 * @project demo
 * @description 描述信息
 */
import Constants from "../../common/Constants";
import { FoodInfo } from "../../model/DataModels";
import { startMode } from "../../utils/Util";

@Component
export struct FoodListItem {
  private foodItem: FoodInfo = new FoodInfo();
  private modeName: string = '';
  private foodListIndex: number = Constants.DEFAULT_ZERO;

  cateData() {
    if (this.modeName === 'multiton') {
      startMode({
        'foodItemId': this.foodItem.id,
        'modeName': this.modeName,
        'foodListIndex': this.foodListIndex
      }, 'MultitonAbility')
    } else if (this.modeName === 'specified') {
      startMode({
        'target': 'pages/FoodDetail',
        'foodItemId': this.foodItem.id,
        'modeName': this.modeName,
        'foodListIndex': this.foodListIndex
      }, 'SpecifiedAbility')
    } else {
      startMode({
        'foodItemId': this.foodItem.id,
        'foodListIndex': this.foodListIndex,
        'modeName': this.modeName
      }, 'SingletonAbility')
    }
  }

  build() {
    Column() {
      Row() {
        Image(this.foodItem.image)
          .objectFit(ImageFit.Contain)
          .autoResize(false)
          .height($r('app.integer.height_normal'))
          .width($r('app.integer.width_normal'))
          .backgroundColor($r('app.color.back_ground_color'))
          .margin({ right: $r('app.integer.margin_normal') })
          .borderRadius(Constants.BORDER_RADIUS)
        Text(this.foodItem.name)
          .fontSize($r('app.integer.font_size_normal'))
          .fontWeight(Constants.FONT_WEIGHT_MD)
      }
      .width(Constants.FULL_PERCENT)
      .height($r('app.integer.height_normal_md'))
      .onClick(() => {
        this.cateData();
      })
    }
    .margin({
      right: $r('app.integer.margin_normal_md'),
      left: $r('app.integer.margin_normal_lg')
    })
  }
}