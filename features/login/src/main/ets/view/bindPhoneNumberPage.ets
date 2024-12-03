import { bindPhoneNumber } from "../components/bind/bindPhoneNumber"

@Component
export struct bindPhoneNumberPage{
  build() {
    Column() {
      bindPhoneNumber()
    }
    .width('100%')
    .backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}