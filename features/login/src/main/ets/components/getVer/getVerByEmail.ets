import auth, { VerifyCodeAction } from "@hw-agconnect/auth"
import { promptAction } from "@kit.ArkUI"
import { BusinessError } from "@kit.BasicServicesKit"

@Component
export struct getVerByEmail {
  //邮箱
  @Consume email: string
  //验证码
  @Consume verCode: string
  //获取验证码按钮文本
  @State verButtonMessage: string = '获取验证码'
  //获取验证码倒计时
  @State timeCounter: number = 60
  //计时器ID
  interval: number = 0



  build() {
    //验证码输入和验证码获取
    Row({ space: 25 }) {
      TextInput({ placeholder: '请输入验证码' })
        .type(InputType.Number)
        .width('55%')
        .onChange(val => {
          this.verCode = val
        })

      //获取验证码
      Button(this.verButtonMessage)
        .enabled(this.verButtonMessage === '获取验证码')
        .onClick(() => {
          this.getVer()
        })
    }
  }

  getVer() {
    //申请手机验证码
    auth.requestVerifyCode({
      action: VerifyCodeAction.REGISTER_LOGIN,
      lang: 'zh_CN',
      sendInterval: 60,
      verifyCodeType: {
        email: this.email,
        kind: 'email'
      }
    }).then(verifyCodeResult => {
      //验证码申请成功
      promptAction.showToast({ message: '获取成功，请及时查收！' })
      //倒计时
      this.interval = setInterval(() => {
        if (this.timeCounter < 0) {
          //清除定时器
          clearInterval(this.interval)
          //重置倒计时
          this.timeCounter = 60
          //重置定时器编号
          this.interval = 0
          //重置按钮内容
          this.verButtonMessage = '获取验证码'
          return
        }
        this.verButtonMessage = `${this.timeCounter}秒后重试`
        this.timeCounter--
      }, 1000)
      //获取两次获取验证码的最小间隔
      verifyCodeResult.getShortestInterval()
      //获取验证码有效时间
      verifyCodeResult.getValidityPeriod()
    }).catch((err: BusinessError) => {
      //验证码申请失败
      promptAction.showToast({ message: '获取出错，请稍后再试！' })
      //获取验证码错误，15秒后重新获取
      this.timeCounter = 15
      //倒计时
      this.interval = setInterval(() => {
        if (this.timeCounter < 0) {
          //清除定时器
          clearInterval(this.interval)
          //重置倒计时
          this.timeCounter = 60
          //重置定时器编号
          this.interval = 0
          //重置按钮内容
          this.verButtonMessage = '获取验证码'
          return
        }
        this.verButtonMessage = `${this.timeCounter}秒后重试`
        this.timeCounter--
      }, 1000)
      console.log('测试' + err.code + err.message)
    });
  }
}