import { playListModel } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"

@Component
export struct musicList {
  @Consume playList: playListModel

  build() {
    List({ space: 12 }) {
      ForEach(this.playList.musicList, (val: musicModel, index) => {
        ListItem() {
          Row({ space: 15 }) {
            Image($r(val.Info.img))
              .size({ width: 45, height: 45 })
              .borderRadius(5)
            Column({ space: 7 }) {
              Text(val.Info.name)
                .fontSize(15)
              Row({ space: 5 }) {
                Text(val.Info.info)
                  .fontColor('#ffff0000')
                  .border({ width: 1, color: '#ffff0000', radius: 2 })
                  .fontSize(10)
                Text(val.Info.singer)
                  .fontColor('#ff2d2d2d')
                  .fontSize(10)
              }
            }.alignItems(HorizontalAlign.Start)

            Button() {
              Image($r('app.media.music_more'))
            }.backgroundColor(Color.Transparent)
            .position({ right: 1, top: 20 })
            .size({ width: 10, height: 10 })
          }.width('95%')
          .alignItems(VerticalAlign.Center)

        }
      })
    }.backgroundColor('#ffff')
  }
}