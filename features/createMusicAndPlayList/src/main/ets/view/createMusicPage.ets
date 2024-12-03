import { musicCoverAndName } from "../components/music/coverAndName"
import { tagAndSinger } from "../components/music/tagAndSinger"

@Component
export struct createMusicPage {
  @Provide cover: string =
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/musicCover%2FDefaultCover.png?token=7ac009b4-370a-4489-bedd-c08adce361d7'
  @Provide name: string = '新建歌曲'
  @Provide tag: string = 'VIP'
  @Provide singer: string = '佚名'

  build() {
    Column({ space: 30 }) {
      Blank()
        .height('20%')
      musicCoverAndName()
      tagAndSinger()
    }
    .width('100%')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}