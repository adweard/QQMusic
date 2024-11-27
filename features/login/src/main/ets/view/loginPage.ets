import { phoneNumberLogin } from "../components/phoneNumberLogin"

@Component
export struct loginPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Row() {
      Column() {
        phoneNumberLogin()
      }
      .width('100%')
    }
    .height('100%')
  }
}
