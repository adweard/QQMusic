import { musicInfoModel, suggestMusicList } from '../model/musicInfoModel'
import { getRandomInt } from '../utils/getRandomInt'
import { orderList } from '../utils/orderList'

@Component
export struct suggestListView {
  @State suggestInfoList: string[] =
    ['猜你喜欢的「华语」好歌', '专属你的「治愈」精选 ', '根据「不如不见」为你推荐', '听过的薛之谦 为你推荐',
      '听过的陈奕迅 为你推荐']
  @Consume suggestInfo: string
  @Consume suggestMusicList: musicInfoModel[][]

  aboutToAppear(): void {
    orderList(this.suggestMusicList, suggestMusicList[0])
  }

  build() {
    Column({ space: 15 }) {
      Text(this.suggestInfo)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      List() {
        ForEach(this.suggestMusicList, (val: musicInfoModel[], index) => {
          ListItem() {
            List({ space: 10 }) {
              ForEach(val, (item: musicInfoModel, index) => {
                ListItem() {
                  Row({ space: 10 }) {
                    Image($r(item.img))
                      .size({ height: 50, width: 50 })
                      .borderRadius(5)
                    Row() {
                      Column({ space: 10 }) {
                        Text(item.name)
                          .fontSize(15)
                          .fontWeight(FontWeight.Medium)
                        Row({ space: 6 }) {
                          Image($r('app.media.like'))
                            .size({ height: 10, width: 10 })
                            .visibility(item.like ? Visibility.Visible : Visibility.None)
                          Text(item.info)
                            .fontSize(10)
                            .fontColor('#1296db')
                            .outline({ width: 1, color: '#1296db', radius: 2 })
                            .visibility(item.info == '' ? Visibility.None : Visibility.Visible)

                          Text(item.singer)
                            .fontSize(10)
                            .fontColor('#ff434343')
                        }.justifyContent(FlexAlign.Start)
                      }.alignItems(HorizontalAlign.Start)

                      Image($r('app.media.play'))
                        .size({ width: 15, height: 15 })
                    }.justifyContent(FlexAlign.SpaceBetween)
                    .width('76%')

                  }.width(360)
                }
              })
            }
          }

        })
      }
      .listDirection(Axis.Horizontal)
      .scrollSnapAlign(ScrollSnapAlign.START)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .friction(1.1)
    }
    .alignItems(HorizontalAlign.Start)
  }
}