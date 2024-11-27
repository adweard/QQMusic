import { userInfo, UserInfoList } from "../model/userInfo";
import { cloudCommon, cloudFunction } from "@kit.CloudFoundationKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { cloudStorage } from '@kit.CloudFoundationKit';
import testHttp from "../utils/HTTPUtil/getTest";
import auth from "@hw-agconnect/auth"

interface testModel {
  code: number,
  message: string
}

@Component
export struct userInfoSign {
  @State globalId: string = '2';
  @State thisUserInfo: userInfo = UserInfoList[0]

  build() {
    Column({ space: 8 }) {
      //头像
      Image(this.thisUserInfo.userAvatar)
        .size({ width: 80 })
        .borderRadius(50)
      //用户名
      Text(this.thisUserInfo.userName)
        .fontSize(25)
        .fontColor('#ffff')

      Text(this.thisUserInfo.locate + '  ·  乐龄' + this.thisUserInfo.joinDuration)
        .fontSize(14)
        .fontColor('#FFB8B8B8')
      Row({ space: 20 }) {
        this.userInfoBuilder(this.thisUserInfo.focus, '关注')
        this.userInfoBuilder(this.thisUserInfo.follower, '粉丝')
        this.userInfoBuilder(this.thisUserInfo.level, '级')
      }

      Button('测试')
        .onClick(async () => {
          this.getId()
          // testHttp.getTest().then(res => {
          //   this.globalId = res.message
          // })
          auth.signIn({
            autoCreateUser: true,
            "credentialInfo": {
              "kind": "hwid"
            }
          })
            .then(signInResult => {
              console.info("test", "signInHwid success " + signInResult.getUser().getUid());
            })
            .catch((error: BusinessError) => {
              console.error("test", "signInHwid error " + error.code + error.message);
            })
          let provider = auth.getAuthProvider();
          cloudCommon.init({ authProvider: provider });
          provider.getAccessToken(false).then(val => {
            console.log('sign aaa+---' + val)
          })
        })
      Button('退出')
        .onClick(() => {
          auth.signOut()
          AppStorage.setOrCreate('sign', 0)
        })
      Text(this.globalId)
        .fontSize(10)
        .fontColor('#ffff')

    }.width('100%')
    .alignItems(HorizontalAlign.Center)

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

  private async getId() {

    console.log('测试按钮被点击了')
    //填入需要调用的云函数名称
    cloudFunction.call({
      name: 'hi', timeout: 3 * 1000,
      data: {
        "name": "zhang san",
      }
    })
      .then((res: cloudFunction.FunctionResult) => {
        console.log('测试进then了')
        console.log('测试' + JSON.stringify(res.result))

        this.globalId = (res.result as testModel).message
      }).catch((err: BusinessError) => {
      console.log('测试' + err.name + '-' + err.code + '-' + err.message)
      console.log('测试进catch了')
    })
    let bucket: cloudStorage.StorageBucket = cloudStorage.bucket()
    bucket.getDownloadURL('music/fushishanxia.mp3').then((downloadURL: string) => {
      console.info(`getDownloadURL: ${downloadURL}`);
    }).catch((err: BusinessError) => {
      console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
    });
  }
}
