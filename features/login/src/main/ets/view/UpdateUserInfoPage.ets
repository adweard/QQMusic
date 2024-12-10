import { AvatarAndName } from "../components/updateUserInfo/AvatarAndName"
import { cloudDatabase } from "@kit.CloudFoundationKit";
import { musicInfo } from "../module/music";
import { BusinessError } from "@kit.BasicServicesKit";
import { userInfo } from "../module/userInfo";


@Component
export struct updateUserInfoPage {
  build() {
    Column() {
      AvatarAndName()
      Button('测试')
        .onClick(async () => {
          let databaseZone = cloudDatabase.zone("music");
          let condition = new cloudDatabase.DatabaseQuery(musicInfo);
          condition.equalTo('UID', 1)
          databaseZone.query(condition).then(val => {
            console.log('upsert' + JSON.stringify(val))
          }).catch((err: BusinessError) => {
            console.log('upsert' + err.code + err.message)
          })
          let databaseZone2 = cloudDatabase.zone("user");
          let condition2 = new cloudDatabase.DatabaseQuery(userInfo);
          condition2.equalTo('name', '我')
          databaseZone2.query(condition2).then(val => {
            console.log('upsert' + JSON.stringify(val))
          }).catch((err: BusinessError) => {
            console.log('upsert' + err.code + err.message)
          })

        })
    }.backgroundColor('#FCFDFF')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}