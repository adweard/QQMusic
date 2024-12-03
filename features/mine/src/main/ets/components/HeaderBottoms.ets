import auth from "@hw-agconnect/auth"
import { cloudDatabase, cloudStorage } from '@kit.CloudFoundationKit';

@Component
export struct HeaderBottoms {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  @State isShow: boolean = false
  @StorageLink('sign') isSign: number = AppStorage.get('sign') as number

  build() {
    Row({ space: 110 }) {

      //左侧更多按钮
      Image($r('app.media.more_left'))
        .size({ width: 20 })
        .onClick(async () => {
          let storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();
          const url = await storageBucket.getDownloadURL(`music/fushishanxia.mp3`)
          console.log('默认头像下载地址' + url)

        })

      //添加状态选项
      Text('+添加状态')
        .offset({ left: '5.5%' })

        .fontSize(14)
        .fontColor('#ffb8b8b8')
      Row({ space: 20 }) {

        //搜索按钮
        Image($r('app.media.search'))
          .onClick(() => {
            this.pageIndexInfos.pushPathByName('createMusic', null)
          })
          .size({ width: 22 })

        //右侧更多按钮
        Image($r('app.media.more'))
          .size({ width: 22 })
          .enabled(this.isSign == 1)
          .onClick(() => {
            this.isShow = true
          })
          .bindSheet($$this.isShow, this.moreBuilder(),
            { height: 300 })
      }
    }.width('100%')
    .justifyContent(FlexAlign.Center)

  }

  @Builder
  moreBuilder() {
    Column({ space: 10 }) {
      //占位
      Blank()
        .height(50)

      Text('修改用户信息')
        .fontSize(20)
        .onClick(() => {
          this.pageIndexInfos.pushPathByName('updateUserInfo', null)
        })

      Divider()
        .color('#ff676767')
        .width('100%')

      Text('绑定/改绑手机')
        .fontSize(20)
        .onClick(() => {
          this.isShow = false
          this.pageIndexInfos.pushPathByName('bindPhone', null)
        })

      Divider()
        .color('#cc676767')
        .width('100%')

      Text('绑定/改绑邮箱')
        .fontSize(20)
        .onClick(() => {
          this.isShow = false
          this.pageIndexInfos.pushPathByName('bindEmail', null)
        })

      Divider()
        .color('#ff676767')
        .width('100%')

      Text('修改密码')
        .fontSize(20)
        .onClick(() => {
        })

      Divider()
        .color('#ff676767')
        .width('100%')

      Text('退出登录')
        .fontSize(20)
        .fontColor('#ffff0000')
        .onClick(() => {
          auth.signOut()
          AppStorage.setOrCreate('sign', 0)
          this.isShow = false
        })

    }
  }
}