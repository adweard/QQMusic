import { playListModel, playListModelList } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"
import { musicPlayer } from "../utils/MusicPlayerUtil"
import { media } from '@kit.MediaKit';
import ShowToast from '../utils/showToastUtil'

@Component
export struct mainPagePlayer {
  @State musicImg: string = ''
  @State angel: number = 0
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number
  @State musicName: string = ''
  @StorageLink('isPlaying') @Watch('playingStateChange') isPlaying: boolean = false
  @State singer: string = ''
  @StorageLink('player') player: media.AVPlayer | null = null
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  @State isPlayList: boolean = false
  @State isShow: boolean = false
  @StorageLink('playList') playList: playListModel = AppStorage.get('playList') as playListModel
  private preSeek: number = 0

  async aboutToAppear(): Promise<void> {

    let playIndex: number | null = null
    let playlist: playListModel | null = null
    let playMusic: musicModel | null = null
    //如果正在播放歌曲的序列号为空，说明第一次登录或播放列表为空
    if (typeof AppStorage.get('playIndex') == "undefined") {
      this.isPlayList = false
    } else {
      this.isPlayList = true
      //重启程序，播放列表有东西，但此时player对象不存在
      if (AppStorage.get('player') == undefined) {
        this.preSeek = AppStorage.get('preSeek') as number
        let playListIndex = AppStorage.get('playListIndex') as number
        AppStorage.setOrCreate('playList', playListModelList[playListIndex])
        let playIndex = AppStorage.get('playIndex') as number
        AppStorage.setOrCreate('playMusic', playListModelList[playListIndex].musicList[playIndex])

        let playMusic = playListModelList[playListIndex].musicList[playIndex]
        this.musicImg = playMusic.Info.img
        this.musicName = playMusic.Info.name
        this.singer = playMusic.Info.singer
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
    }
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
        .onAppear(() => {
          animateTo({
            duration: 20000,
            iterations: -1,
            curve: Curve.Linear
          }, () => {
            this.angel = 360
          })
        })
        .size({ width: 20, height: 20 })
        .onClick(() => {
          if (this.isPlayList) {
            musicPlayer.playBefore()
          }
        })

      //播放暂停
      Image(this.isPlaying ? $r('app.media.pause_mainpageplayer') : $r('app.media.play_mainpageplayer'))
        .size({ width: 28, height: 28 })
        .margin({ left: 8, right: 8 })

        .onClick(() => {
          if (this.isPlayList) {
            if (this.isPlaying == true) {
              this.player?.pause()
            } else {
              this.player?.play()
            }
          }
        })
      //播放下一首
      Image($r('app.media.changeMusic_player'))
        .margin({ right: 20 })
        .size({ width: 20, height: 20 })
        .rotate({ angle: 180 })
        .onClick(() => {
          if (this.isPlayList) {
            musicPlayer.playNext()
          }
        })
      //歌单列表半模态弹窗
      Image($r('app.media.musicList'))
        .size({ width: 20 })
        .onClick(() => {
          this.isShow = true
        })

    }.backgroundColor('#FCFDFF')
    .size({ width: '100%', height: 50 })
    .onClick(() => {
      if (this.isPlayList) {
        AppStorage.setOrCreate('player', this.player)
        this.pageIndexInfos.pushPathByName('musicPlayer', AppStorage.get('playMusic'))
      }
    })
    .bindSheet($$this.isShow, this.songListBindSheetBuilder(), {
      detents: ['80%', '79.5%'],
      dragBar: true,
      backgroundColor: '#ffffffff',
      showClose: false

    })

  }

  playIndexChange() {
    while (AppStorage.get('playList') == undefined) {
      console.log('测试111')
    }
    console.log('测试获取playList' + AppStorage.get('playList') + '-' + AppStorage.get('playIndex'))
    this.musicImg =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.img
    this.musicName =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.name
    this.singer =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.singer
  }

  playingStateChange() {
    this.isPlaying = AppStorage.get('isPlaying') as boolean
    if (this.isPlayList == false) {
      this.getPlayerInfo()
    }
  }

  getPlayerInfo() {
    this.isPlayList = true
    let playlist = AppStorage.get('playList') as playListModel
    let playIndex = AppStorage.get('playIndex') as number
    let playMusic = playlist.musicList[playIndex]
    this.musicImg = playMusic.Info.img
    this.musicName = playMusic.Info.name
    this.singer = playMusic.Info.singer
    this.isPlaying = AppStorage.get('isPlaying') as boolean
    this.player = AppStorage.get('player') as media.AVPlayer
  }

  @Builder
  songListBindSheetBuilder() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.playList.musicList, (value: musicModel, index) => {
          ListItem() {
            Row() {
              Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start }) {
                Text(value.Info.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#ff000000')
                  .maxLines(1)

                  .textOverflow({ overflow: TextOverflow.Ellipsis })


                Text('·' + value.Info.singer)
                  .fontSize(15)
                  .fontWeight(FontWeight.Normal)
                  .fontColor('#ff545454')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

              }.width(300)


              Image($r('app.media.close'))
                .size({ height: 20 })
                .onClick(() => {
                  if (this.playList.musicList.length > 1) {
                    //如果播放列表还有大于等于一首歌
                    this.playList.musicList.splice(index, 1)
                    AppStorage.setOrCreate('playList', this.playList)
                    console.log('测试' + index)
                    AppStorage.setOrCreate('playIndex', index)
                    if (index == this.playList.musicList.length - 1) {
                      console.log('测试 删除最后一首歌')
                    }
                  } else {
                    //如果播放列表只有一首歌了
                    ShowToast.longToast($r('app.string.onlyOne_MusicList'))
                  }
                  if (index == AppStorage.get("playIndex")) {
                    musicPlayer.playNext()
                  }
                })
            }.alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
            .height(35)
          }.width('100%')
        })
      }.width('100%')
      .padding({ bottom: Number(AppStorage.get('bottomHeight')) })


      Blank(20)
    }.offset({ top: 20 })

  }
}

