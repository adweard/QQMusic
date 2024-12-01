import { HeaderBottoms } from "../components/HeaderBottoms";

import { userInfoSignOut } from "../components/UserInfoSignOut";
import { userInfoSign } from "../components/UserInfoSingin";

@Component
export struct MinePage {

  @StorageLink('sign') isSign: number = (AppStorage.get('sign') as number)

  build() {
    Column() {
      HeaderBottoms()
      Blank()
        .height(40)
      if (this.isSign == 1) {
        userInfoSign()
      } else {
        userInfoSignOut()
      }



    }.size({ height: '100%', width: '100%' })
    .padding({ top: Number(AppStorage.get('topHeight')) })
    .backgroundColor('#ff7e2c00')

  }
}
