import auth from "@hw-agconnect/auth"
import { cloudCommon, cloudDatabase, cloudStorage } from "@kit.CloudFoundationKit"
import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { BusinessError, request } from "@kit.BasicServicesKit"
import { fileIo as fs } from '@kit.CoreFileKit';

@Component
export struct musicCoverAndName {
  @Consume cover: string
  @Consume name: string

  build() {
    Column({ space: 30 }) {
      Image(this.cover)
        .onClick(() => {
          this.uploadCOver()
        })
        .size({ width: 100, height: 100 })
      TextInput({ placeholder: '输入歌名' })
        .width('80%')
        .onChange(val => {
          this.name = val
        })
    }
  }

  async uploadCOver() {
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
        cloudPath: `musicCover/${fileName}`    // 云侧路径
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
        const url = await storageBucket.getDownloadURL(`musicCover/${fileName}`)
        console.log('测试获取下载地址' + url)

      }).catch((err: BusinessError) => {
        console.error(`uploadFile failed, Code: ${err.code}, message: ${err.message}`);
      });
    });
  }
}