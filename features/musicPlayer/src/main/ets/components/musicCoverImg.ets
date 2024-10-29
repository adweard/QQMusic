import { playListModel } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"

@Component
export struct musicCoverImg {
  @State musicImg: string = (AppStorage.get('playMusic') as musicModel).Info.img
  @State angel: number = 0
  @StorageLink('playIndex') @Watch('playIndexChange') playIndex: number = AppStorage.get('playIndex') as number

  aboutToAppear(): void {
    animateTo({

      duration: 20000,
      iterations: -1,
      curve: Curve.Linear

    }, () => {
      this.angel = 360
    })
  }

  build() {
    Image($r(this.musicImg))
      .size({ width: 300, height: 300 })
      .borderRadius(220)
      .border({ width: 40, color: "#ff1d1d1d" })
      .rotate({
        angle: this.angel
      })
  }

  playIndexChange() {
    this.musicImg =
      (AppStorage.get('playList') as playListModel).musicList[AppStorage.get('playIndex') as number].Info.img
  }
}