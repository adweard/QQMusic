import auth from "@hw-agconnect/auth"
import { cloudCommon, cloudDatabase, cloudStorage } from "@kit.CloudFoundationKit"
import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { BusinessError, request } from "@kit.BasicServicesKit"
import { fileIo as fs } from '@kit.CoreFileKit';
import { userInfo } from "../../module/userInfo";

@Component
export struct AvatarAndName {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  interval: number = 0;
  @State avatar: string = ''
  @State oldName: string = ''
  @State newName: string = ''

  build() {
    Column({ space: 20 }) {

      //头像
      Image(this.avatar)
        .size({ width: 50, height: 50 })
        .borderRadius(50)
        .onClick(async () => {
          this.updateAvatar()
        })


      //用户名
      TextInput({ placeholder: this.oldName })
        .width('60%')
        .onChange(val => {
          this.newName = val
        })

      //确认按键
      Button('确认')
        .onClick(() => {
          this.updateName()
          this.updateAGC()
          this.pageIndexInfos.clear()
        })

    }.onAppear(async () => {
      this.getAvatarAndName()
    })

  }

  async updateAvatar() {
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
  }

  async getAvatarAndName() {
    let user = await auth.getCurrentUser()
    this.avatar = user?.getPhotoUrl()!
    this.oldName = user?.getDisplayName()!
    this.interval = setInterval(async () => {
      if (this.avatar != '' && this.oldName != '') {
        //清除定时器
        console.log('清除定时器')
        clearInterval(this.interval)
        return
      }
      let user = await auth.getCurrentUser()
      this.avatar = user?.getPhotoUrl()!
      this.oldName = user?.getDisplayName()!
    }, 100)
  }

  async updateName() {
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
      UserInfo.name = this.newName
      UserInfo.avatar = this.avatar
      let record = await databaseZone.upsert(UserInfo);
      console.info(`Succeeded in upserting a book , result：` + JSON.stringify(record));
    } catch (err) {
      console.error(`Failed to upsert a book , Code: ${err.code}, message: ${err.message}`);
    }
  }

  async updateAGC() {
    let user = await auth.getCurrentUser()
    user?.updateProfile({
      displayName: this.newName,
      photoUrl: this.avatar
    })
  }
}