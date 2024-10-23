import { List_1, recommendListModel } from "../model/recommendListModel"
import getAverageColor from "../utils/getColorPicker"
import { SwipeRefresher } from "@kit.ArkUI"

@Component
export struct RecommendListView {
  @ObjectLink recommendModel: recommendListModel
  @State RecommendList: recommendListModel[] = List_1

  aboutToAppear(): void {
    this.RecommendList.forEach((val) => {
      val.overlayColor = getAverageColor(getContext(this), val.imgName)
    })


  }

  build() {
    List({ space: 10 }) {


      ForEach(this.RecommendList, (obj: recommendListModel, index) => {
        ListItem() {
          Column() {
            //推荐标题
            Row() {

              Text(obj.title)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
            }
            .height(40)
            .justifyContent(FlexAlign.Center)
            .width(150)
            .linearGradient({
              colors: [[obj.overlayColor[0], 0.15],
                [obj.overlayColor[1], 1.0]]
            })

            //推荐语
            Row() {
              Text(obj.msg)
                .fontColor(Color.White)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
            }.height(40)
            .width(150)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(obj.overlayColor[0])
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .size({ height: 200, width: 150 })
          .borderRadius(10)
          .clip(true)
          .backgroundImage($r(obj.img))
          .backgroundImageSize({ height: 200, width: 150 })

        }.height(200)
        .width(150)
        .onClick(() => {
          //TODO  列表一：推荐歌单跳转
          console.log('测试被点击' + obj.overlayColor)
        })

      })
    }.listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)

  }


}