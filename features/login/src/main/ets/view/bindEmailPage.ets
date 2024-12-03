import { bindEmail } from "../components/bind/bindEmail"

@Component
export struct bindEmailPage {
  build() {
    Column() {
      bindEmail()
    }
    .width('100%')
    .backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}