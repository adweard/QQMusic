import auth from '@hw-agconnect/auth';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { getVerByPhoneNumber } from '../getVer/getVerByPhoneNumber';

@Component
export struct phoneNumberLogin {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //登陆状态
  @StorageLink('sign') isSign: number = AppStorage.get('sign') as number
  //手机号
  @Provide phoneNumber: string = ''
  //验证码
  @Provide verCode: string = ''
  @State password: string = ''
  //登陆模式  电话号码登陆：0，邮箱登录：1
  @Consume signType: number
  //验证方式 验证码：false，密码：true
  @State verType: boolean = false

  build() {
    Column({ space: 20 }) {
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

      //手机号输入
      TextInput({ placeholder: '请输入手机号' })
        .type(InputType.PhoneNumber)
        .width('80%')
        .onChange(val => {
          this.phoneNumber = val
        })

      if (this.verType == false) {
        getVerByPhoneNumber()
          .width('80%')
      } else {
        TextInput({ placeholder: '请输入密码' })
          .onChange(val => {
            this.password = val
          })
          .type(InputType.Password)
          .width('80%')
      }


      Blank()
        .height(10)

      Row() {
        Button('登 录')
          .width('45%')
          .enabled(this.phoneNumber.length == 11)
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
      Text(this.signType == 0 ? '切换至邮箱登录' : '切换至手机号登陆')
        .decoration({ type: TextDecorationType.Underline, color: '#ff00d9ff' })
        .fontSize(15)
        .fontColor('#ff00d9ff')
        .onClick(() => {
          this.signType = 1
        })


    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }

  signINByPassword() {
    auth.signIn({
      //密码登录
      credentialInfo: {
        kind: 'phone',
        phoneNumber: this.phoneNumber,
        countryCode: '86',
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
        phoneNumber: this.phoneNumber,
        countryCode: '86',
        verifyCode: this.verCode
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