import { media } from "@kit.MediaKit";
import { MusicPlayMode } from "mediacommon"
import { musicPlayer } from '../utils/MusicPlayerUtil'
import ShowToast from '../utils/showToastUtil'

@Component
export struct playerControllerButton {
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @StorageLink('isPlaying') @Watch('playStateChange') isPlaying: boolean = AppStorage.get('isPlaying') as boolean
  @StorageLink('playMode') @Watch('playModeChange') musicPlayMode: number = AppStorage.get('playMode') as number
  @State playModeImg: Resource = $r('app.media.shunxubofang_player')

  aboutToAppear(): void {
    this.playModeChange()
  }

  build() {
    Row({ space: 50 }) {
      //(单曲循环 -> 随机播放 ->顺序播放 -> 单曲循环)
      Image(this.playModeImg)
        .size({ width: 23 })
        .onClick(() => {
          //如果是单曲循环
          if (this.musicPlayMode == MusicPlayMode.SINGLE_CYCLE) {
            //切换到随机播放
            AppStorage.setOrCreate('playMode', MusicPlayMode.RANDOM)
            ShowToast.shortToast($r('app.string.playMOde_RANDOM'))
            //如果是随机播放
          } else if (this.musicPlayMode == MusicPlayMode.RANDOM) {
            //切换到顺序播放
            AppStorage.setOrCreate('playMode', MusicPlayMode.ORDER)
            ShowToast.shortToast($r('app.string.playMOde_ORDER'))
            //如果是顺序播放
          } else if (this.musicPlayMode == MusicPlayMode.ORDER) {
            //切换到单曲循环
            AppStorage.setOrCreate('playMode', MusicPlayMode.SINGLE_CYCLE)
            ShowToast.shortToast($r('app.string.playMOde_SINGLE'))
          }
        })


      //上一首
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
        .onClick(() => {
          musicPlayer.playBefore()
        })

      //播放/暂停
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
        })

      //下一首
      Image($r('app.media.changeMusic_player'))
        .size({ height: 30, width: 30 })
        .rotate({ angle: 180 })
        .onClick(() => {
          musicPlayer.playNext()

        })
      //歌曲列表
      Image($r('app.media.musicList'))
        .size({ width: 20 })
    }.justifyContent(FlexAlign.Center)
    .width('95%')
  }

  playStateChange() {
    this.isPlaying = AppStorage.get('isPlaying') as boolean
  }

  playModeChange() {

    if (this.musicPlayMode == MusicPlayMode.SINGLE_CYCLE) {
      this.playModeImg = $r('app.media.danquxunhuan_player')
    }
    if (this.musicPlayMode == MusicPlayMode.RANDOM) {
      this.playModeImg = $r('app.media.suijishunxu_player')
    }
    if (this.musicPlayMode == MusicPlayMode.ORDER) {
      this.playModeImg = $r('app.media.shunxubofang_player')
    }
  }

  @Builder
  songListBindSheetBuilder() {
    Column() {

    }
  }
}