import { media } from "@kit.MediaKit";

@Component
export struct playerControllerButton {
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @State isPlaying: boolean = true

  build() {
    Row({ space: 60 }) {
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
      Image(this.isPlaying ? $r('app.media.stop_player') : $r('app.media.play_player'))
        .size({ height: 40, width: 40 })
        .onClick(() => {
          if (this.isPlaying == true) {
            this.player.pause()
            this.isPlaying = false
          } else {
            this.player.play()
            this.isPlaying = true
          }
        })
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
        .rotate({ angle: 180 })
    }.justifyContent(FlexAlign.Center)
    .width('90%')
  }
}