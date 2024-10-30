import { mainPagePlayer } from "musicplayer";
import { playListModel } from "recommend";
import { Header } from "../components/Header";
import { listControllerButtons } from "../components/listControllerButtons";
import { musicList } from "../components/musicList";
import { playListInfo } from "../components/playListInfo";

@Component
export struct MusicListPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  @State param: playListModel[] = this.pageIndexInfos.getParamByName('musicList') as playListModel[]
  @Provide playList: playListModel = this.param[0]

  aboutToAppear(): void {
    if (!this.param[0].imgName) {
      setTimeout(() => {
      }, 2000)
      AppStorage.setOrCreate('playList', this.playList)
    } else {
      AppStorage.setOrCreate('playList', this.playList)
    }

  }

  build() {
    Stack() {
      Column() {
        Header()
        List() {
          ListItem() {
            //歌单信息
            playListInfo()
          }

          ListItemGroup({ header: this.header }) {

            ListItem() {
              //音乐列表
              musicList()
            }
          }

        }.scrollBar(BarState.Off)
        .sticky(StickyStyle.Header)
        .edgeEffect(EdgeEffect.None)
      }

      //播放控件
      Column() {
        mainPagePlayer()
        Blank()
          .width('100%')
          .height(20)
          .backgroundColor('#FCFDFF')
      }
      .position({ y: '95%' })
    }
    .width('100%')
    .backgroundColor('#ff530606')
    .height('100%')
    .padding({ bottom: Number(AppStorage.get('bottomHeight')) })
  }

  @Builder
  header() {
    //播放、收藏、评论、转发等按钮
    listControllerButtons()
  }
}
