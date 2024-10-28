import { playListModel } from "recommend"


@Component
export struct listControllerButtons {
  @Consume playList: playListModel

  build() {
    Column({ space: 20 }) {
      Row() {

        Button() {
          Image($r("app.media.play"))
        }.size({ width: 40, height: 40 })
        .backgroundColor(Color.Transparent)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {

        })


        Blank()
          .width(10)
        Text('播放全部')
          .fontSize(15)

        Blank()
          .width('22%')
        //收藏
        Row({ space: 5 }) {
          Image($r('app.media.unselected'))
            .size({ width: 27, height: 27 })
          Text(this.playList.likeNumber.toString())
            .fontSize(10)
        }
        .onClick(() => {
        })

        Blank()
          .width(24)
        //评论
        Row({ space: 5 }) {
          Image($r('app.media.comments'))
            .size({ width: 27, height: 27 })
          Text(this.playList.likeNumber.toString())
            .fontSize(10)
        }
        .onClick(() => {
        })

        Blank()
          .width(24)
        Image($r("app.media.forward_player"))
          .size({ width: 22, height: 22 })


      }

      Row() {
        Text(this.playList.musicList.length + '首')
          .fontSize(13)
          .fontColor('#ff393737')
        Button() {
          Image($r('app.media.download'))

        }.size({ width: 20, height: 20 })
        .backgroundColor(Color.Transparent)
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
    .height(105)
    .backgroundColor('#ffff')
    .padding({
      left: '2.5%',
      right: '2.5%',
      top: 10,
    })

  }
}