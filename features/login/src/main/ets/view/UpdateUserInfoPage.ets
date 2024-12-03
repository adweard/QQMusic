import { AvatarAndName } from "../components/updateUserInfo/AvatarAndName"

@Component
export struct updateUserInfoPage {
  build() {
    Column() {
    AvatarAndName()
    }.backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}