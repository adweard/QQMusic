@Component
export struct phoneNumberLogin {
  @State phoneNumber: string = ''
  @State var: string = ''

  build() {
    Column() {
      //手机号输入
      TextInput({ placeholder: '请输入手机号' })
        .width('80%')
        .onChange(val => {
          this.phoneNumber = val
        })
      //验证码输入和验证码获取
      Row() {
        TextInput({ placeholder: '请输入验证码' })
          .width(60)
          .onChange(val => {
            this.var = val
          })
        Button('获取验证码')
          .onClick(() => {
          })
      }
      .width('80%')

      Button('登录')
        .enabled(this.phoneNumber.length == 11 && this.var.length == 6)
        .onClick(() => {

        })


    }
  }
}