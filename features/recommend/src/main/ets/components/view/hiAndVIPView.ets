import { systemDateTime } from "@kit.BasicServicesKit"

@Component
export struct hiAndVipView {
  @State currTime: string = 'Hi'

  aboutToAppear(): void {
    //获取系统时间戳并转换为具体时间
    let date = new Date(systemDateTime.getTime())
    let hour: number = date.getHours()
    // console.log('测试 + ' + hour)
    if (hour >= 6 && hour < 9) {
      this.currTime = '早上好'
    } else if (hour >= 9 && hour < 13) {
      this.currTime = '上午好'
    } else if (hour >= 12 && hour < 14) {
      this.currTime = '中午好'
    } else if (hour >= 14 && hour < 18) {
      this.currTime = '下午好'
    } else if (hour >= 18 && hour < 24) {
      this.currTime = '晚上好'
    } else if (hour >= 0 && hour < 6) {
      this.currTime = '夜深了'
    } else {
      this.currTime = '你好'
    }
  }

  build() {
    Row() {
      Text(this.currTime)
        .fontSize(25)
        .fontWeight(FontWeight.Medium)
      Button() {
        Row({ space: 10 }) {
          Image($r('app.media.vip_icon'))
            .height(25)
          Text('用专属音质，享品质音乐>')
            .fontSize(13)
            .fontColor('#c62824a0')
        }
        .backgroundColor('#488067ea')
        .borderRadius(15)
        .height(28)
        .width(220)
        .justifyContent(FlexAlign.Center)
      }.backgroundColor(Color.Transparent)

    }.justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({ right: 10 })
  }
}