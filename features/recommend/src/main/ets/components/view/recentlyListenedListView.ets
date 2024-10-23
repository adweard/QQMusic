import { playListModel, playListModelList } from "../model/playListModel"
import getAverageColor from "../utils/getColorPicker"

@Component
export struct recentlyListenedListView {
  @State playListArray: playListModel[] = []

  aboutToAppear(): void {
    playListModelList.forEach(val => {
      val.layoutColor = getAverageColor(getContext(this), val.imgName)
    })
    this.playListArray = playListModelList

  }

  build() {
    Column({ space: 15 }) {
      Row() {

        Text('最近常听')
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
      }.width('100%')
      .justifyContent(FlexAlign.Start)

      List({ space: 10 }) {
        ForEach(this.playListArray, (val: playListModel, index) => {
          ListItem() {
            Column() {
              Row() {
                Text(val.listName)
                  .fontSize(12)
                  .fontColor('#ffff')
                  .fontWeight(FontWeight.Bold)
              }
              .padding({ left: 5, top: 5, right: 2 })
              .alignItems(VerticalAlign.Top)
              .height(40)
              .width(90)
              .linearGradient({
                colors: [['#9f040430', 0.45],
                  ['#160a0a5d', 1]]
              })

              Row() {
                Text('歌单')
                  .fontColor('#ffff')
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
              }
              .position({ left: 5, bottom: 5 })
              .backgroundColor('#99000000')
              .height(16)
              .width(30)
              .justifyContent(FlexAlign.Center)
              .borderRadius(4)
            }
            .alignItems(HorizontalAlign.Start)
            .clip(true)
            .size({ width: 90, height: 90 })
            .backgroundImage($r(val.listImg))
            .backgroundImageSize({ height: 90, width: 90 })
            .borderRadius(10)
            .justifyContent(FlexAlign.Start)

          }
        })
      }.listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)

    }
  }
}
