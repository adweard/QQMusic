import { playListModel } from "recommend"

@Component
export struct playListInfo {
  @Consume playList: playListModel

  build() {
    Column({ space: 20 }) {
      Image($r(this.playList.listImg))
        .size({ height: 150, width: 150 })
        .borderRadius(10)
      Text(this.playList.listName)
        .fontSize(20)
        .fontWeight(FontWeight.Bolder)
        .fontColor('#ffff')
      Row({ space: 10 }) {
        Image(this.playList.listCreator.userAvatar)
          .size({ width: 30, height: 30 })
          .borderRadius(30)
        Text(this.playList.listCreator.userName)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('#ffff')

      }
    }
    .size({ width: '100%', height: 250 })

  }
}