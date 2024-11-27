import { musicPlayer } from "musicplayer/src/main/ets/utils/MusicPlayerUtil"
import { playListModel } from "recommend"
import { musicModel } from "recommend/src/main/ets/viewModel/musicModel"
import { BusinessError } from "@kit.BasicServicesKit";

@Component
export struct musicList {
  @Consume playList: playListModel
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  private disseminateList = this.playList

  aboutToAppear(): void {

  }

  build() {
    List({ space: 12 }) {
      ForEach(this.playList.musicList, (val: musicModel, index) => {
        ListItem() {
          Row({ space: 15 }) {
            Image($r(val.Info.img))
              .size({ width: 45, height: 45 })
              .borderRadius(5)
            Column({ space: 7 }) {
              Text(val.Info.name)
                .fontSize(15)
              Row({ space: 5 }) {
                //音乐标签(VIP\SQ\...)
                Text(val.Info.info)
                  .fontColor('#ffff0000')
                  .border({ width: 1, color: '#ffff0000', radius: 2 })
                  .fontSize(10)
                //歌手信息
                Text(val.Info.singer)
                  .fontColor('#ff2d2d2d')
                  .fontSize(10)
              }
            }.alignItems(HorizontalAlign.Start)

            //每首歌的更多按钮
            Button() {
              Image($r('app.media.music_more'))
            }.backgroundColor(Color.Transparent)
            .position({ right: 1, top: 20 })
            .size({ width: 10, height: 10 })
          }.width('95%')
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.pageIndexInfos.pushPathByName('musicPlayer', val)
            AppStorage.setOrCreate('playList', this.disseminateList)
            AppStorage.setOrCreate('playMusic', val)

            AppStorage.setOrCreate('playIndex', index)

            console.log('状态机进入播放状态' + val.Info.name + index.toString())

            //TODO 控制播放循环与否的对象
            AppStorage.setOrCreate("musicPlayer", musicPlayer)
            musicPlayer.playByRawSrc(val.musicRawFile).then((player) => {
              //TODO 控制播放状态机的对象
              AppStorage.setOrCreate("player", player)
              console.log('测试 进入播放了')
              console.log('测试播放对象时长' + player.duration)
            }).catch((err: BusinessError) => {
              console.log('测试 进入播放异常了')
              console.log('测试播放出错' + err.name + '-' + err.code + '-' + err.message)
            })
            console.log("测试 onclick结束")
          })

        }.onClick(() => {
          AppStorage.setOrCreate('playList', this.playList)
        })
      })
    }.backgroundColor('#ffff')
    .padding({ bottom: 170 })
    .constraintSize({
      minHeight: 450
    })
  }
}