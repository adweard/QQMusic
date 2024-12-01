import { regByEmail } from "../components/Register/regByEmail"
import { regByPhoneNumber } from "../components/Register/regByPhoneNumber"

@Component
export struct regPage {
  //注册模式  电话号码登陆：false，邮箱登录：true
  @Provide regType: boolean = false

  build() {
    Column() {
      if (this.regType == false ) {
        regByPhoneNumber()
      } else {
        regByEmail()
      }
    }
    .backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}