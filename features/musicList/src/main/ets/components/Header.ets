@Component
export struct Header {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Row({ space: 20 }) {
      Button() {
        Image($r('app.media.back'))
      }
      .size({ width: 20, height: 20 })
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.pageIndexInfos.pop()
      })

      Blank()
        .width('68%')
      Button() {
        Image($r('app.media.search'))
      }
      .size({ width: 20, height: 20 })
      .backgroundColor(Color.Transparent)

      Button() {
        Image($r('app.media.more'))
      }
      .size({ width: 20, height: 20 })
      .backgroundColor(Color.Transparent)
    }
    .justifyContent(FlexAlign.Start)
    .height(50)
    .width('95%')
    .margin({ top: Number(AppStorage.get('topHeight')) })

  }
}