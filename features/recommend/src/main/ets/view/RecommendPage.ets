import { recommendListModel, } from "../viewModel/recommendListModel"
import { musicInfoModel, likeAndRecommendMusicList, suggestMusicList } from "../viewModel/musicInfoModel";
import { RecommendList } from "../components/RecommendList";
import { suggestList } from "../components/suggestList";
import { orderList } from "../utils/orderList";
import { getRandomInt } from "../utils/getRandomInt";
import { likeAndRecommendList } from "../components/likeAndRecommendList";
import { hiAndVip } from "../components/hiAndVIP";
import { Header } from "../components/Header";
import { recentlyListenedList } from "../components/recentlyListenedList";

@Component
export struct RecommendPage {
  @Provide likeAndRecommendMusicList: musicInfoModel[][] = []
  @State isRefreshing: boolean = false
  @State suggestInfoList: string[] =
    ['猜你喜欢的「华语」好歌', '专属你的「治愈」精选 ', '根据「不如不见」为你推荐', '听过的薛之谦 为你推荐',
      '听过的陈奕迅 为你推荐']
  @Provide suggestInfo: string = this.suggestInfoList[0]
  @Provide suggestMusicList: musicInfoModel[][] = []
  @State color: string = ''
  
  build() {
    Column() {
      //顶部栏位组件
      Header()

      Refresh({ refreshing: $$this.isRefreshing }) {
        List({ space: 40 }) {
          //打招呼，跳转VIP
          ListItem() {
            hiAndVip()
          }

          //推荐列表
          ListItem() {
            RecommendList({ recommendModel: new recommendListModel('', '', '', '') })
          }.width('95%')

          //红心歌曲和音乐推荐
          ListItem() {
            likeAndRecommendList()
          }

          //大数据推荐列表
          ListItem() {
            // suggestListItem()
            suggestList()
          }

          //最近常听
          ListItem() {
            recentlyListenedList()
          }

          ListItem() {

          }.backgroundColor('#424242')

        }

        .scrollBar(BarState.Off)
        .width('95%')
        .height('88%')
      }.onRefreshing(() => {

        let index = getRandomInt(0, 4)
        let t = this.suggestInfo
        this.suggestInfo = this.suggestInfoList[index]
        while (t == this.suggestInfo) {
          let index = getRandomInt(0, 4)
          this.suggestInfo = this.suggestInfoList[index]
        }
        for (let i = 0; i < suggestMusicList.length / 3 + 1; i++) {
          // this.likeAndRecommendMusicList[i] = []
          this.suggestMusicList[i] = []
          for (let t = 0; t < 3; t++) {
            // this.likeAndRecommendMusicList[i][t] = likeAndRecommendMusicList[i * 3+t]
            this.suggestMusicList[i][t] = suggestMusicList[index][i * 3 +t]

          }
        }

        setTimeout(() => {
          this.isRefreshing = false
        }, 1000)

      })
    }
    .backgroundColor('#F8F9FD')

  }
}



