import auth from "@hw-agconnect/auth"
import { getVerByPhoneNumber } from "../getVer/getVerByPhoneNumber"
import { BusinessError } from "@kit.BasicServicesKit"
import { promptAction } from "@kit.ArkUI"

@Component
export struct bindPhoneNumber {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //手机号
  @Provide phoneNumber: string = ''
  //验证码
  @Provide verCode: string = ''

  build() {
    Column({ space: 20 }) {

      //占位
      Blank()
        .height('20%')

      //输入手机号
      TextInput({ placeholder: '请输入手机号' })
        .type(InputType.PhoneNumber)
        .width('80%')
        .onChange(val => {
          this.phoneNumber = val
        })

      //获取验证码
      getVerByPhoneNumber()
        .width('80%')

      //确认更改按钮
      Button('确认')
        .enabled(this.phoneNumber.length == 11 && this.verCode.length == 6)
        .onClick(() => {
          this.linkPhone()
        })
    }
  }

  async linkPhone() {
    let user = await auth.getCurrentUser()
    user?.link({
      kind: 'phone',
      phoneNumber: this.phoneNumber,
      verifyCode: this.verCode,
      countryCode: '86'
    }).then((res) => {
      promptAction.showToast({ message: '绑定成功！', duration: 2000 })
      this.pageIndexInfos.clear()
    }).catch((err: BusinessError) => {
      promptAction.showToast({ message: '绑定出错，请稍后再试!' })
      console.log('测试 绑定出错' + JSON.stringify(err))
    })
  }
}