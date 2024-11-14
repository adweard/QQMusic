import { playListModel } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"

@Component
export struct nameAndAuthor {
  @Consume musicInfo: musicModel
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number

  build() {
    Column({ space: 10 }) {
      Text(this.musicInfo.Info.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bolder)
        .fontColor('#fff')
        .width(150)//超长文本跑马灯
        .textOverflow({ overflow: TextOverflow.MARQUEE })
      Text(this.musicInfo.Info.singer)
        .fontSize(16)
        .fontColor('#fff')
        .width(100)//超长文本跑马灯
        .textOverflow({ overflow: TextOverflow.MARQUEE })
    }.size({ width: '95%', height: 100 })
    .alignItems(HorizontalAlign.Start)
  }

  playIndexChange() {
    //更新播放的音乐的ID
    this.musicInfo = (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number]
  }
}