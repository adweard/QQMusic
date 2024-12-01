import { emailLogin } from "../components/Login/emailLogin"
import { phoneNumberLogin } from "../components/Login/phoneNumberLogin"


@Component
export struct loginPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //登陆模式  电话号码登陆：0，邮箱登录：1
  @Provide signType: number = 0

  build() {
    Row() {
      Column() {
        if (this.signType == 0) {
          phoneNumberLogin()
        } else {
          emailLogin()
        }
      }
      .width('100%')
    }
    .backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}
