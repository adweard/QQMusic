@Component
export struct HeaderView {
  @State searchRecommendList: string[] = ['绅士 薛之谦', '薛之谦', '陈奕迅', '十年', '富士山下']
  controller: SearchController = new SearchController()
  @State searchRecommendIndex: number = 0
  private intervalIndex: number = 0

  aboutToAppear(): void {
    //搜索栏广告轮播
    this.intervalIndex = setInterval(() => {
      this.searchRecommendIndex = this.searchRecommendIndex + 1
      this.searchRecommendIndex = this.searchRecommendIndex % this.searchRecommendList.length
    }, 5000)
  }
  aboutToDisappear(): void {
    clearInterval(this.intervalIndex)
  }

  build() {
    Row({ space: 10 }) {
      Button() {
        Image($r('app.media.more_icon'))
          .size({ width: 25, height: 25 })

      }
      .backgroundColor(Color.Transparent)

      Row() {
        Search({ placeholder: this.searchRecommendList[this.searchRecommendIndex], controller: this.controller })
          .backgroundColor(Color.Transparent)
          .width(200)
          .enableKeyboardOnFocus(false)
          .caretStyle({
            color: Color.Transparent
          })
          .onClick(() => {
            this.controller.stopEditing()
          })
        Blank()
          .width(35)

        Button() {
          Image($r('app.media.QRCode_icon'))
        }.size({ width: 22, height: 22 })
        .backgroundColor(Color.Transparent)

        Blank()
          .width(35)

        Button() {
          Image($r('app.media.mic_icon'))
        }.size({ width: 32, height: 32 })
        .backgroundColor(Color.Transparent)

      }.width('75%')
      .backgroundColor('#EAEDF2')
      .borderRadius(20)
      .height(30)

    }
    .height(50)
    .width('95%')
    .margin({ top: Number(AppStorage.get('topHeight')) })
    .alignItems(VerticalAlign.Top)
  }
}