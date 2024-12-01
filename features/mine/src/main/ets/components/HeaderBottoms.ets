@Component
export struct HeaderBottoms {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Row({ space: 110 }) {
      Image($r('app.media.more_left'))
        .size({ width: 20 })
      Text('+添加状态')
        .offset({ left: '5.5%' })

        .fontSize(14)
        .fontColor('#ffb8b8b8')
      Row({ space: 20 }) {
        Image($r('app.media.search'))
          .onClick(() => {
            this.pageIndexInfos.pushPathByName('createUserInfo', null)
          })
          .size({ width: 22 })
        Image($r('app.media.more'))
          .size({ width: 22 })
      }
    }.width('100%')
    .justifyContent(FlexAlign.Center)

  }
}