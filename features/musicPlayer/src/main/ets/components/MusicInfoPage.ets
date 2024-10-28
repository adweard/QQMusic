import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"
import { header } from "./header"
import { musicCoverImg } from "./musicCoverImg"
import { musicInfo } from "./musicInfo"
import { playbackProgress } from "./playbackProgress"
import { playerControllerButton } from "./playerControllerButtons"

@Component
export struct musicInfoPage {
  @Consume musicInfo: musicModel
  @Provide musicImg: string = this.musicInfo.Info.img

  build() {
    Column() {
      Blank()
        .height(110)
      //黑胶转图
      musicCoverImg()
      Blank()
        .height(80)
      //音乐信息及收藏评论按钮
      musicInfo()
      playbackProgress()
      Blank()
        .height(50)
      playerControllerButton()
    }.alignItems(HorizontalAlign.Center)
  }
}