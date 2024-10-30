import { media } from "@kit.MediaKit";
import { musicPlayer } from '../utils/MusicPlayerUtil'
import { musicCoverImg } from "./musicCoverImg";
import { musicInfo } from "./musicInfo";

@Component
export struct playerControllerButton {
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @StorageLink('isPlaying') @Watch('playStateChange') isPlaying: boolean = AppStorage.get('isPlaying') as boolean


  build() {
    Row({ space: 60 }) {
      //上一首
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
        .onClick(() => {
          musicPlayer.playBefore()
        })
      Image(this.isPlaying ? $r('app.media.stop_player') : $r('app.media.play_player'))
        .size({ height: 40, width: 40 })
        .onClick(() => {
          if (this.isPlaying == true) {
            this.isPlaying = false
            this.player.pause()

          } else {
            this.isPlaying = true
            this.player.play()

          }
          // musicCoverImg().change()
        })
      //下一首
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
        .rotate({ angle: 180 })
        .onClick(() => {
          musicPlayer.playNext()
        })
    }.justifyContent(FlexAlign.Center)
    .width('90%')

  }

  playStateChange() {
    this.isPlaying = AppStorage.get('isPlaying') as boolean
  }
}