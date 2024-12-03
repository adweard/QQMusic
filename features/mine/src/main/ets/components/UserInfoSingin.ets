import auth from "@hw-agconnect/auth"
import { cloudCommon, cloudDatabase } from '@kit.CloudFoundationKit';
import { userInfo } from "../model/userInfo";
import { request } from "@kit.BasicServicesKit";


@Component
export struct userInfoSign {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //用户名
  @State userName: string = ''
  //用户头像URL
  @State avatar: string = ''
  //用户乐龄
  @State regDuration: string = '-'
  //用户关注数
  @State like: number = 1
  //用户粉丝数
  @State follower: number = 1
  //用户等级
  @State level: number = 6
  interval: number = 0;

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
      Text(this.regDuration + '乐龄')
        .fontSize(14)
        .fontColor('#FFB8B8B8')

      //用户信息
      Row({ space: 20 }) {

        //关注数
        Row({ space: 5 }) {
          Text(this.like.toString())
            .fontSize(17)
            .fontColor('#ffff')
          Text('关注')
            .fontSize(14)
            .fontColor('#FFB8B8B8')
        }

        //粉丝数
        Row({ space: 5 }) {
          Text(this.follower.toString())
            .fontSize(17)
            .fontColor('#ffff')
          Text('粉丝')
            .fontSize(14)
            .fontColor('#FFB8B8B8')
        }

        //等级
        Row({ space: 5 }) {
          Text(this.level.toString())
            .fontSize(17)
            .fontColor('#ffff')
          Text('级')
            .fontSize(14)
            .fontColor('#FFB8B8B8')
        }

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
      
      this.updateUserInfo()
      this.interval = setInterval(() => {
        if (this.regDuration != '-' && this.userName != '' && this.avatar != null) {
          //清除定时器
          console.log('清除定时器')
          clearInterval(this.interval)
          return
        }
        this.updateUserInfo()
        this.userName = user!.getDisplayName()
        this.avatar = user!.getPhotoUrl()
      }, 100)
    })

  }

  async updateUserInfo() {
    try {
      let databaseZone = cloudDatabase.zone('user');
      let condition = new cloudDatabase.DatabaseQuery(userInfo);
      let user = await auth.getCurrentUser()
      let UUID = user?.getUid()
      console.log('query' + UUID)
      condition.equalTo('UUID', UUID);
      let resultArray = await databaseZone.query(condition);
      this.like = resultArray[0].like!
      this.follower = resultArray[0].follower!
      this.regDuration = resultArray[0].regDuration!
      this.level = resultArray[0].level!

      console.info(`Succeeded in querying , result：` + JSON.stringify(resultArray));
    } catch (err) {
      console.error(`Failed to query , Code: ${err.code}, message: ${err.message}`);
    }
  }
}
