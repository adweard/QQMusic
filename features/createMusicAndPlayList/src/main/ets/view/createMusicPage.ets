import auth from "@hw-agconnect/auth"
import { musicCoverAndName } from "../components/music/coverAndName"
import { tagAndSinger } from "../components/music/tagAndSinger"
import { cloudCommon, cloudDatabase } from "@kit.CloudFoundationKit"
import { request } from "@kit.BasicServicesKit"
import { musicInfo } from "../moudle/music"


@Component
export struct createMusicPage {
  @Provide cover: string =
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/musicCover%2FDefaultCover.png?token=7ac009b4-370a-4489-bedd-c08adce361d7'
  @Provide name: string = '新建歌曲'
  @Provide tag: string = 'VIP'
  @Provide singer: string = '佚名'
  @Provide isLike: boolean = false
  @Provide musicURL: string = ''
  @Provide realMusicName: string = ''

  build() {
    Column({ space: 30 }) {
      Blank()
        .height('15%')
      //上传照片和歌名
      musicCoverAndName()

      //选择tag\歌手\是否收藏\播放源流
      tagAndSinger()

      //上传钮
      Button('确定')// .enabled(this.cover !=
        //   'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/musicCover%2FDefaultCover.png?token=7ac009b4-370a-4489-bedd-c08adce361d7' &&
        //   this.name != '新建歌曲' && this.musicURL != '' && this.realMusicName != '')
        .onClick(() => {
          this.uploadMusic()
        })
    }
    .width('100%')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }

  async uploadMusic() {
    try {
      let authProvider = auth.getAuthProvider();
      cloudCommon.init({
        region: cloudCommon.CloudRegion.CHINA,
        authProvider: authProvider,
        functionOptions: { timeout: 10 * 1000 },
        storageOptions: { mode: request.agent.Mode.BACKGROUND, network: request.agent.Network.ANY },
        databaseOptions: { schema: "schema.json", traceId: "traceId" }
      })
      let databaseZone = cloudDatabase.zone("music");
      // let condition = new cloudDatabase.DatabaseQuery(musicInfo);
      // condition.equalTo('UID', 1)
      // let ans = await databaseZone.query(condition)
      // console.log('upsert' + JSON.stringify(ans))
      let music = new musicInfo()
      music.musicURL = this.musicURL
      music.cover = this.cover
      music.name = this.name
      music.tag = this.tag
      music.singer = this.singer
      music.trueName = this.realMusicName
      music.isLike = this.isLike
      console.log('upsert数据' + JSON.stringify(music))
      let record = await databaseZone.upsert(music);
      console.info(`Succeeded in upserting a book , result：` + JSON.stringify(record));
    } catch (err) {
      console.error(`Failed to upsert  , Code: ${err.code}, message: ${err.message}`);
    }

  }
}