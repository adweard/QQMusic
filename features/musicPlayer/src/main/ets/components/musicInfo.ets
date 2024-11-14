import { playListModel } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"
import { lycModel } from "../utils/lycUtil"

@Component
export struct musicInfo {
  @Consume musicInfo: musicModel
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number

  build() {
    Row() {
      Column() {
        Row({ space: 5 }) {
          //歌名
          Text(this.musicInfo.Info.name)
            .fontSize(25)
            .fontColor('#ffffffff')
            .width(120)//超长文本跑马灯
            .textOverflow({ overflow: TextOverflow.MARQUEE })
          //标签
          Text(this.musicInfo.Info.info)
            .fontSize(15)
            .fontColor('#ff9d9d9d')
            .backgroundColor('#9a4f4f4f')
            .borderRadius(5)
            .width(this.musicInfo.Info.info.length * 15 + 8)
            .height(20)
            .textAlign(TextAlign.Center)
        }

        //歌手
        Text(this.musicInfo.Info.singer)
          .fontSize(20)
          .fontColor("#ffa4a4a4")
      }.alignItems(HorizontalAlign.Start)

      Row({ space: 5 }) {
        Image($r('app.media.like_player'))
          .size({ width: 21, height: 18 })
          .onClick(() => {
          })
        Text(this.musicInfo.likeNumber.toString())
          .fontSize(10).fontColor('#ffdedede')
        Blank()
          .width(10)
        Image($r('app.media.comment_player'))
          .size({ width: 23, height: 23 })
          .onClick(() => {
          })
        Text(this.musicInfo.commentNumber.toString())
          .fontSize(10).fontColor('#ffdedede')
      }
    }.width('90%')
    .justifyContent(FlexAlign.SpaceBetween)

  }

  playIndexChange() {
    this.musicInfo = (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number]
    this.musicInfo.lrcEntry =
      lycModel.getLycFile((AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].musicRawFile)

  }
}