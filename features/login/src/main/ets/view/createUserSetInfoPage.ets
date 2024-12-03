import { setInfo } from "../components/createUserInfo/setInfo"

@Component
export struct createUserSetInfoPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()

  build() {
    Column() {
      setInfo()
    }
    .width('100%')
    .backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })

  }
}