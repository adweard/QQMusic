import auth from "@hw-agconnect/auth"
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { UserInfo } from


@Component
export struct userInfoSign {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //用户名
  @State userName: string = ''
  //用户头像URL
  @State avatar: string = ''
  //用户乐龄
  @State regDuration: string = ''
  //用户关注数
  @State like: number = 0
  //用户粉丝数
  @State follower: number = 0
  //用户等级
  @State level: number = 0

  async aboutToAppear(): Promise<void> {

  }

  build() {
    Column({ space: 8 }) {
      //头像
      Image(this.avatar)
        .size({ width: 100, height: 100 })
        .borderRadius(50)


      //用户名
      Text(this.userName)
        .fontSize(25)
        .fontColor('#ffff')


      //乐龄
      Text('三年乐龄')
        .fontSize(14)
        .fontColor('#FFB8B8B8')
      Row({ space: 20 }) {
        this.userInfoBuilder(11, '关注')
        this.userInfoBuilder(111, '粉丝')
        this.userInfoBuilder(2, '级')
      }


      Button('退出')
        .onClick(() => {
          auth.signOut()
          AppStorage.setOrCreate('sign', 0)
        })


    }.width('100%')
    .alignItems(HorizontalAlign.Center)
    .onAppear(async () => {
      let user = await auth.getCurrentUser()
      this.userName = user!.getDisplayName()
      this.avatar = user!.getPhotoUrl()
    })

  }

  updateUserInfo() {
    try {
      let databaseZone = cloudDatabase.zone('userInfo');
      let condition = new cloudDatabase.DatabaseQuery(UserInfo);
      let user = await auth.getCurrentUser()
      let UUID = user?.getUid()
      condition.equalTo('UUID', UUID);
      let resultArray = await databaseZone.query(condition);

      console.info(`Succeeded in querying , result：` + JSON.stringify(resultArray));
    } catch (err) {
      console.error(`Failed to query , Code: ${err.code}, message: ${err.message}`);
    }
  }

  @Builder
  userInfoBuilder(number: number, str: string) {
    Row({ space: 5 }) {
      Text(number.toString())
        .fontSize(17)
        .fontColor('#ffff')
      Text(str)
        .fontSize(14)
        .fontColor('#FFB8B8B8')
    }
  }
}
