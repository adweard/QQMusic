import { cloudCommon, cloudStorage } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import auth from "@hw-agconnect/auth"
import { promptAction } from "@kit.ArkUI"
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { userInfo } from '../../module/userInfo';


@Component
export struct setInfo {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //头像
  @State avatar: string | Resource = $r('app.media.DefaultAvatar')
  //用户名
  @State name: string = ''
  @StorageLink('musicListIDArr') musicListIDArr: string = ''

  build() {
    Column({}) {
      //占位
      Blank()
        .height('20%')

      //头像
      Image(this.avatar)
        .objectFit(ImageFit.Fill)
        .size({ width: 120, height: 120 })
        .onClick(async () => {
          let storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();
          // 使用photoAccessHelper选择指定的文件
          let photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
          photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
          photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
          let photoViewPicker = new photoAccessHelper.PhotoViewPicker();
          photoViewPicker.select(photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
            let fileUri = photoSelectResult.photoUris[0];
            console.info(`pick file ${fileUri}`);
            let fileName = fileUri.split('/').pop() as string;
            console.info(`file name ${fileName}`);
            let cacheFile = `${Date.now()}_${fileName}`;
            console.info(`cacheFile ${cacheFile}`);
            let cacheFilePath = getContext().cacheDir + '/' + cacheFile;

            // 将选中文件copy至cache目录下，文件名为cacheFile
            try {
              let srcFile = fs.openSync(fileUri);
              let dstFile = fs.openSync(cacheFilePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
              fs.copyFileSync(srcFile.fd, dstFile.fd);
              fs.closeSync(srcFile);
              fs.closeSync(dstFile);
            } catch (e) {
              console.info(`copy file failed ${e.message}`);
              return;
            }

            // 上传至云存储默认实例
            storageBucket.uploadFile(getContext(this), {
              localPath: cacheFile, // 本地文件路径，context.cacheDir目录下的文件
              cloudPath: `avatar/${fileName}`    // 云侧路径
            }).then(async (task: request.agent.Task) => {
              task.on('progress', (progress) => {
                console.info(`on progress ${JSON.stringify(progress)}`);
              });
              task.on('completed', (progress) => {
                console.info(`on completed ${JSON.stringify(progress)}`);
              });
              task.on('failed', (progress) => {
                console.error(`on failed ${JSON.stringify(progress)}`);
              });
              task.on('response', (response) => {
                console.info(`on response ${JSON.stringify(response)}`);
              });

              // start task
              task.start((err: BusinessError) => {
                if (err) {
                  console.error(`Failed to start the uploadFile task, Code: ${err.code}, message: ${err.message}`);
                } else {
                  console.info(`Succeeded in starting a uploadFile task.`);
                }
              });
              const url = await storageBucket.getDownloadURL(`avatar/${fileName}`)
              console.log('测试获取下载地址' + url)
              this.avatar = url
            }).catch((err: BusinessError) => {
              console.error(`uploadFile failed, Code: ${err.code}, message: ${err.message}`);
            });
          });


        })

      //提示语
      Text('点击这里选择头像')
        .fontColor('#ff696969')
        .fontSize(15)

      //占位
      Blank()
        .height('5%')

      //用户名
      TextInput({ placeholder: '请输入用户名' })
        .width('60%')
        .onChange(val => {
          this.name = val
        })


      //占位
      Blank()
        .height('10%')

      Button('确认')
        .onClick(async () => {
          this.upsert()
          this.createUserInfo()
        })
    }.size({ height: '100%', width: '100%' })
  }

  async createUserInfo() {
    let user = await auth.getCurrentUser()
    if (typeof this.avatar === 'string' && this.name != '') {
      //更新当前用户的头像和用户名信息
      user?.updateProfile({
        displayName: this.name,
        photoUrl: this.avatar
      })

      //创建用户在云数据库内的信息
      this.upsert()
      //跳转回主页
      this.pageIndexInfos.clear()
    } else if (typeof this.avatar === 'object') {
      promptAction.showToast({ message: '请选择一个心仪的头像！' })
    } else if (this.name == '') {
      promptAction.showToast({ message: '请输入用法户名！' })
    }


  }

  async upsert() {
    try {
      let authProvider = auth.getAuthProvider();
      cloudCommon.init({
        region: cloudCommon.CloudRegion.CHINA,
        authProvider: authProvider,
        functionOptions: { timeout: 10 * 1000 },
        storageOptions: { mode: request.agent.Mode.BACKGROUND, network: request.agent.Network.ANY },
        databaseOptions: { schema: "schema.json", traceId: "traceId" }
      })
      let user = await auth.getCurrentUser()
      let UUID = user!.getUid()
      let databaseZone = cloudDatabase.zone("user");
      let UserInfo = new userInfo()
      UserInfo.UUID = UUID
      UserInfo.musicListArr = this.musicListIDArr
      UserInfo.like = 0
      UserInfo.follower = 0
      UserInfo.level = 0
      UserInfo.regDuration = '0年'
      UserInfo.name = this.name
      UserInfo.avatar = this.avatar as string
      let record = await databaseZone.upsert(UserInfo);
      console.info(`Succeeded in upserting a book , result：` + JSON.stringify(record));
    } catch (err) {
      console.error(`Failed to upsert a book , Code: ${err.code}, message: ${err.message}`);
    }
  }
}