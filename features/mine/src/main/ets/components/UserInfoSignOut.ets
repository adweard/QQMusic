@Component
export struct userInfoSignOut {
  @State globalId: string = '2';
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 20 }) {
      //默认头像
      Image($r('app.media.signoutAvatar'))
        .size({ width: 80 })
        .borderRadius(50)
        .borderWidth(1)
        .borderColor('#ff000000')
        .backgroundColor('#fff')
        .onClick(() => {
          this.pageIndexInfos.pushPathByName('loginPage', null)
        })
      //提示信息
      Text('点击用户头像登录/注册')
        .fontSize(20)
        .fontColor('#ffff')


    }.width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}