import { media } from "@kit.MediaKit";
import { MusicPlayMode } from "mediacommon"
import { playListModel } from "recommend";
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel";
import { musicPlayer } from '../utils/MusicPlayerUtil'
import ShowToast from '../utils/showToastUtil'

@Component
export struct playerControllerButton {
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @StorageLink('isPlaying') @Watch('playStateChange') isPlaying: boolean = AppStorage.get('isPlaying') as boolean
  @StorageLink('playMode') @Watch('playModeChange') musicPlayMode: number = AppStorage.get('playMode') as number
  @State playModeImg: Resource = $r('app.media.shunxubofang_player')
  @StorageLink('playList') playList: playListModel = AppStorage.get('playList') as playListModel
  @State isShow: boolean = false
  interval: number = 0

  aboutToAppear(): void {
    this.playModeChange()
    
    //倒计时
    this.interval = setInterval(() => {
      if (this.player != null) {
        //清除定时器
        clearInterval(this.interval)
        return
      }
      this.player = AppStorage.get('player') as media.AVPlayer
    }, 1000)
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
        .onClick(() => {
          this.isShow = true
        })
        .size({ width: 20 })
        .bindSheet($$this.isShow, this.songListBindSheetBuilder(), {
          detents: ['80%', '79.5%'],
          dragBar: true,
          backgroundColor: '#ffffffff',
          showClose: false

        })
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