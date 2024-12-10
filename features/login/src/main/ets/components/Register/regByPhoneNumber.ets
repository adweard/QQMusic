import { promptAction } from '@kit.ArkUI';
import auth from "@hw-agconnect/auth";
import { BusinessError } from '@kit.BasicServicesKit';
import { getVerByPhoneNumber } from '../getVer/getVerByPhoneNumber';

@Component
export struct regByPhoneNumber {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //手机号
  @Provide phoneNumber: string = ''
  //验证码
  @Provide verCode: string = ''
  //密码1
  @State password_1: string = ''
  //密码2
  @State password_2: string = ''
  //注册模式  电话号码登陆：false，邮箱登录：true
  @Consume regType: boolean

  build() {
    Column({ space: 20 }) {

      //返回键
      Row() {
        Image($r('app.media.back_left_black'))
          .size({ height: 30 })
          .onClick(() => {
            this.pageIndexInfos.pop()
          })
      }.justifyContent(FlexAlign.Start)
      .width('90%')

      //标语
      Row() {
        Text('新用户手机号注册')
          .fontSize(15)
          .fontColor('#ff676767')
      }.justifyContent(FlexAlign.Start)
      .width('85%')

      //占位
      Blank()
        .height(50)

      //手机号
      TextInput({ placeholder: '请输入手机号' })
        .onChange(val => {
          this.phoneNumber = val
        })
        .type(InputType.PhoneNumber)
        .width('80%')

      //密码1
      TextInput({ placeholder: '请输入密码' })
        .onChange(val => {
          this.password_1 = val
        })
        .type(InputType.Password)
        .width('80%')

      //密码2
      TextInput({ placeholder: '请确认密码' })
        .onChange(val => {
          this.password_2 = val
        })
        .type(InputType.Password)
        .width('80%')

      //验证码
      getVerByPhoneNumber()
        .width('80%')

      //占位
      Blank()
        .height(20)

      //注册键
      Button('注  册')
        .onClick(() => {
          this.register()
        })
        .fontSize(30)
        .width('40%')

      //占位
      Blank()
        .height('20%')

      //切换登录模式键
      Text('切换至邮箱注册')
        .decoration({ type: TextDecorationType.Underline, color: '#ff00d9ff' })
        .fontSize(15)
        .fontColor('#ff00d9ff')
        .onClick(() => {
          this.regType = !this.regType
        })


    }.width('100%')
    .height('100%')
  }

  register() {
    if (this.password_1 != this.password_2) {
      promptAction.showToast({ message: '两次输入的密码不一致！', duration: 2000 })
      return
    }
    auth.createUser({
      kind: 'phone',
      countryCode: '86',
      phoneNumber: this.phoneNumber,
      password: this.password_1,
      verifyCode: this.verCode
    }).then(val => {
      val.getUser().getPhone()
      AppStorage.setOrCreate('sign', 1)
      this.pageIndexInfos.pushPathByName('createUserInfo', null)
      // 创建用户成功
    }).catch((error: BusinessError) => {
      if (error.code == 401) {
        this.pageIndexInfos.pushPathByName('createUserInfo', null)
        return
      }
      // 创建用户失败
      promptAction.showToast({ message: '创建用户失败，请稍后再试' })
      console.log('注册失败' + error.code + error.message)
    })
  }
}