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

  build() {
    Column() {
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
      }
    }
    .width('100%')
    .backgroundColor('#ff530606')
    .height('100%')
    .margin({ bottom: Number(AppStorage.get('bottomHeight')) })
  }

  @Builder
  header() {
    //播放、收藏、评论、转发等按钮
    listControllerButtons()
  }
}
