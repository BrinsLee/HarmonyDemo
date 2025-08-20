/**
 * @author lipeilin
 * @date 2025/8/18
 * @project demo
 * @description 描述信息
 */
import Constants from '../common/Constants'
import { FoodInfo } from '../model/DataModels'
import { getFoodsData } from '../model/DataUtil'
import { FoodListItem } from './customcomponent/FoodListItem'

@Entry
@Component
struct FoodMain {
  private foodList: Array<FoodInfo>[] = getFoodsData()

  build() {
    Column() {
      Text($r('app.string.startMode'))
        .width(Constants.FULL_PERCENT)
        .height(Constants.TEN_PERCENT)
        .fontWeight(Constants.FONT_WEIGHT_MD)
        .padding($r('app.integer.padding_normal_sm1'))
        .fontSize($r('app.integer.font_size_normal_md1'))
      Column() {
        List() {
          ForEach(this.foodList, (item: FoodInfo[], index) => {
            ListItem() {
              Column() {
                if (index === Constants.DEFAULT_ZERO) {
                  FoodListComp({
                    modeIntro: $r('app.string.multiton'),
                    modeName: 'multiton',
                    foodsList: item,
                    foodListIndex: index
                  })
                } else if (index === Constants.DEFAULT_ONE) {
                  FoodListComp({
                    modeIntro: $r('app.string.specified'),
                    modeName: 'specified',
                    foodsList: item,
                    foodListIndex: index
                  })
                } else {
                  FoodListComp({
                    modeIntro: $r('app.string.singleton'),
                    modeName: 'singleton',
                    foodsList: item,
                    foodListIndex: index
                  })
                }
              }.justifyContent(FlexAlign.Center)
            }
          })
        }.width(Constants.FULL_PERCENT).height(Constants.FULL_PERCENT)
      }
    }.width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .backgroundColor($r('app.color.tab_bar_select_color'))
  }
}


@Component
struct FoodListComp {
  private modeIntro: Resource = {
    bundleName: "",
    moduleName: "",
    id: Constants.DEFAULT_ZERO
  }

  private foodsList: Array<FoodInfo> = [];
  private modeName: string = "";
  private foodListIndex: number = Constants.DEFAULT_ZERO;

  build() {
    Column() {
      Row() {
        Text(this.modeIntro)
          .fontSize($r('app.integer.font_size_normal_sm1'))
          .fontWeight(Constants.FONT_WEIGHT_MD)
          .fontColor($r('app.color.font_color_normal1'))
        Blank()
      }
      .width(Constants.FULL_PERCENT)
      .height($r('app.integer.height_normal_md1'))
      .padding({
        left: $r('app.integer.padding_normal_sm1'),
        top: $r('app.integer.padding_normal_sm1')})

      ForEach(this.foodsList, (item: FoodInfo) => {
        FoodListItem({
          foodItem: item,
          modeName: this.modeName,
          foodListIndex: this.foodListIndex
        })
      })
    }.width(Constants.NINETY_FOUR_PERCENT)
    .borderRadius(Constants.BORDER_RADIUS_NORMAL_MD)
    .margin($r('app.integer.margin_normal'))
    .padding({ bottom: $r('app.integer.padding_normal_sm1') })
    .backgroundColor($r('app.color.white'))
  }
}