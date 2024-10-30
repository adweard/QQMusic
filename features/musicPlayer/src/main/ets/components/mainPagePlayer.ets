import { playListModel, playListModelList } from "recommend"
import { musicModel, RammsteinList } from "recommend/src/main/ets/viewModel/musicModel"
import { musicPlayer } from "../utils/MusicPlayerUtil"
import { media } from '@kit.MediaKit';
import { MediaQueryEvent } from "@kit.ArkUI";

@Component
export struct mainPagePlayer {
  @State musicImg: string = ''
  @State angel: number = 0
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number
  @State musicName: string = ''
  @StorageLink('isPlaying') @Watch('playingStateChange') isPlaying: boolean = false
  @State singer: string = ''
  @State player: media.AVPlayer | null = null
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  async aboutToAppear(): Promise<void> {

    let playIndex: number | null = null
    let playlist: playListModel | null = null
    let playMusic: musicModel | null = null
    if (AppStorage.ref('playList') == undefined) {
      AppStorage.setOrCreate('playList', playListModelList[0])
      playlist = AppStorage.get('playList') as playListModel
      AppStorage.setOrCreate('playMusic', playlist.musicList[0])
      AppStorage.setOrCreate('playIndex', 0)
      playIndex = AppStorage.get('playIndex') as number
      playMusic = playlist.musicList[playIndex]
      this.musicImg = playMusic.Info.img
      this.musicName = playMusic.Info.name
      this.singer = playMusic.Info.singer
      musicPlayer.playByRawSrc(playMusic!.musicRawFile).then((player) => {
        AppStorage.setOrCreate('player', player)
        this.player = player
      })

      this.isPlaying = AppStorage.get('isPlaying') as boolean


    } else {
      playlist = AppStorage.get('playList') as playListModel
      playIndex = AppStorage.get('playIndex') as number
      playMusic = playlist.musicList[playIndex]
      this.musicImg = playMusic.Info.img
      this.musicName = playMusic.Info.name
      this.singer = playMusic.Info.singer
      this.player = AppStorage.get('player') as media.AVPlayer
      this.isPlaying = AppStorage.get('isPlaying') as boolean
      this.player = AppStorage.get('player') as media.AVPlayer

    }

    animateTo({
      duration: 2000,
      iterations: -1,
      curve: Curve.Linear
    }, () => {
      this.angel = 360
    })
  }

  build() {
    Row() {
      Blank()
        .width(8)
      Image($r(this.musicImg))
        .size({ width: 40, height: 40 })
        .borderRadius(40)
        .border({ width: 8.5, color: "#ff1d1d1d" })
        .rotate({
          angle: this.angel
        })
      Blank()
        .width(12)
      Row() {
        Text(this.musicName)
          .fontSize(16)
          .textOverflow({ overflow: TextOverflow.MARQUEE })
        Text('-' + this.singer)
          .fontSize(16)
          .fontColor('#ff7e7e7e')
          .textOverflow({ overflow: TextOverflow.MARQUEE })
      }.width(170)
      .clip(true)

      Blank()
        .width(10)
      //播放上一首
      Image($r('app.media.changeMusic_player'))
        .size({ width: 20, height: 20 })
        .onClick(() => {
          musicPlayer.playBefore()
        })

      //播放暂停
      Image(this.isPlaying ? $r('app.media.pause_mainpageplayer') : $r('app.media.play_mainpageplayer'))
        .size({ width: 28, height: 28 })
        .margin({ left: 8, right: 8 })
        .onClick(() => {
          if (this.isPlaying == true) {
            this.player?.pause()
          } else {
            this.player?.play()
          }
        })
      //播放下一首
      Image($r('app.media.changeMusic_player'))
        .size({ width: 20, height: 20 })
        .rotate({ angle: 180 })
        .onClick(() => {
          musicPlayer.playNext()
        })


    }.backgroundColor('#FCFDFF')
    .size({ width: '100%', height: 50 })
    .onClick(() => {
      AppStorage.setOrCreate('player', this.player)
      this.pageIndexInfos.pushPathByName('musicPlayer', AppStorage.get('playMusic'))
    })

  }

  playIndexChange() {
    this.musicImg =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.img
    this.musicName =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.name
    this.singer =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.singer
  }

  playingStateChange() {
    this.isPlaying = AppStorage.get('isPlaying') as boolean
  }
}