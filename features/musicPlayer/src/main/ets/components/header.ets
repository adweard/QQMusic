@Component
export struct header {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Row() {
      //返回按键
      Button() {
        Image($r('app.media.back_down'))
      }.size({ height: 30, width: 30 })
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.pageIndexInfos.pop()
      })

      //转发按键
      Button() {
        Image($r("app.media.forward_player"))
      }
      .size({ width: 30, height: 30 })
      .backgroundColor(Color.Transparent)
    }
    .height(50)
    .width('90%')
    .justifyContent(FlexAlign.SpaceBetween)

  }
}