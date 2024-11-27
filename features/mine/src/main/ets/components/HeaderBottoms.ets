@Component
export struct HeaderBottoms {
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
          .size({ width: 22 })
        Image($r('app.media.more'))
          .size({ width: 22 })
      }
    }.width('100%')
    .justifyContent(FlexAlign.Center)

  }
}