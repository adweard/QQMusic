import auth from "@hw-agconnect/auth"
import { BusinessError } from "@kit.BasicServicesKit"
import { promptAction } from "@kit.ArkUI"
import { getVerByEmail } from "../getVer/getVerByEmail"

@Component
export struct emailLogin {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //邮箱
  @Provide email: string = ''
  //验证码
  @Provide verCode: string = ''
  //密码
  @State password: string = ''
  //验证方式 验证码：false，密码：true
  @State verType: boolean = false
  //登陆模式  电话号码登陆：0，邮箱登录：1
  @Consume signType: number

  build() {

    Column({ space: 20 }) {
      //应用图标
      Row() {
        Image($r('app.media.back_left_black'))
          .size({ height: 30 })
          .onClick(() => {
            this.pageIndexInfos.pop()
          })
      }.justifyContent(FlexAlign.Start)
      .width('90%')

      //占位
      Blank()
        .height(60)

      //应用图标
      Image($r('app.media.appForgrand'))
        .size({ width: 80, height: 80 })

      //应用名
      Text('QQ音乐')
        .fontSize(20)

      //占位
      Blank()
        .height(50)

      //邮箱输入
      TextInput({ placeholder: '请输入邮箱' })
        .type(InputType.Email)
        .width('80%')
        .onChange(val => {
          this.email = val
        })

      if (this.verType == false) {
        getVerByEmail()
          .width('80%')
      } else {
        TextInput({ placeholder: '请输入密码' })
          .onChange(val => {
            this.password = val
          })
          .width('80%')
          .type(InputType.Password)
      }

      Blank()
        .height(10)

      Row() {
        Button('登 录')
          .width('45%')

          .onClick(() => {
            if (this.verType == false) {
              this.signInByVer()
            } else {
              this.signINByPassword()
            }
          })

        Button('注 册')
          .width('45%')
          .onClick(() => {
            this.pageIndexInfos.pushPathByName('reg', null)
          })
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('70%')

      //占位
      Blank()
        .height('15%')

      //切换验证模式键
      Text(this.verType == false ? '密码登录' : '验证码登录')
        .decoration({ type: TextDecorationType.Underline, color: '#ff00d9ff' })
        .fontSize(15)
        .fontColor('#ff00d9ff')
        .onClick(() => {
          this.verType = !this.verType
        })

      //切换登录模式键
      Text('切换至手机号码登录')
        .decoration({ type: TextDecorationType.Underline, color: '#ff00d9ff' })
        .fontSize(15)
        .fontColor('#ff00d9ff')
        .onClick(() => {
          this.signType = 0
        })


    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }

  signINByPassword() {
    auth.signIn({
      //密码登录
      credentialInfo: {
        kind: 'email',
        email: this.email,
        password: this.password
      },
      autoCreateUser: false
    }).then(val => {
      val.getUser().getPhone()
      AppStorage.setOrCreate('sign', 1)
      this.pageIndexInfos.clear()
    })
      .catch((err: BusinessError) => {
        promptAction.showToast({ message: '账户或验证码错误！' })
        console.log('测试' + err.code + err.message)
      })
  }

  signInByVer() {
    auth.signIn({
      //验证码登录
      credentialInfo: {
        kind: 'phone',
        phoneNumber: '111',
        countryCode: '86',
        verifyCode: '111'
      },
      autoCreateUser: false
    }).then(val => {
      val.getUser().getPhone()
      AppStorage.setOrCreate('sign', 1)
      this.pageIndexInfos.clear()
    })
      .catch((err: BusinessError) => {
        promptAction.showToast({ message: '账户或验证码错误！' })
        console.log('测试' + err.code + err.message)
      })
  }
}