import { LrcEntry } from "../Entry"
import { media } from "@kit.MediaKit"
import { lycModel } from "../utils/lycUtil"
import { playListModel } from "recommend"

@Component
export struct lrcList {
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number
  @State lrc: LrcEntry[] = []
  @State @Watch('playLrcIndexChange') playLrcIndex: number = 0
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @StorageLink('seek') @Watch('timeUpdate') playTime: number = 0
  lrcScroll: Scroller = new Scroller()

  aboutToAppear(): void {
    this.lrc =
      lycModel.getLycFile((AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].musicRawFile)

    this.lrc.forEach((val, index) => {
      if (this.playTime >= val.lineStartTime && this.playTime <= val.lineStartTime + val.lineDuration) {
        this.playLrcIndex = index
      }
      this.lrcScroll.scrollToIndex(this.playLrcIndex, true, ScrollAlign.CENTER)
    })
  }

  build() {
    List({ scroller: this.lrcScroll, space: 30 }) {
      ForEach(this.lrc, (val: LrcEntry, index) => {
        ListItem() {
          Column() {
            Text(val.lineWords)
              .fontColor(
                (val.lineStartTime <= this.playTime && this.playTime <= val.lineStartTime + val.lineDuration) ?
                  '#ff6bff00' : '#ffffffff')
              .fontSize((val.lineStartTime <= this.playTime && this.playTime <= val.lineStartTime + val.lineDuration) ?
                25 : 20)
              .fontWeight((val.lineStartTime <= this.playTime &&
                this.playTime <= val.lineStartTime + val.lineDuration) ? FontWeight.Medium : FontWeight.Normal)

          }.alignItems(HorizontalAlign.Start)
        }
        .onClick(() => {
          this.player.seek(val.lineStartTime + 100)
          this.player.play()
          this.lrcScroll.scrollToIndex(index, true, ScrollAlign.CENTER)
        })
        .transition(TransitionEffect.opacity(0.1))
      })
    }.alignListItem(ListItemAlign.Center)
    .size({ width: '100%', height: '60%' })
    //设置滚动条不可见
    .scrollBar(BarState.Off)
    //设置滑动至列表边缘无效果
    .edgeEffect(EdgeEffect.None)
  }

  playIndexChange() {
    //更新歌词数组
    this.lrc = []
    let newLrc =
      lycModel.getLycFile((AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].musicRawFile)
    this.lrc = newLrc
  }

  playLrcIndexChange() {
    this.lrcScroll.scrollToIndex(this.playLrcIndex, true, ScrollAlign.CENTER)
  }

  timeUpdate() {
    this.lrc.forEach((val, index) => {
      if (this.playTime >= val.lineStartTime && this.playTime <= val.lineStartTime + val.lineDuration) {
        this.playLrcIndex = index
      }
    })
  }
}