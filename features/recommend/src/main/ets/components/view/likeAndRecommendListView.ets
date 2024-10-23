import { likeAndRecommendMusicList, musicInfoModel } from '../model/musicInfoModel'
import { orderList } from '../utils/orderList'

@Component
export struct likeAndRecommendListView {
  @State likeAndRecommendMusicList: musicInfoModel[][] = []

  aboutToAppear(): void {
    //红心歌曲和相似推荐分组
    orderList(this.likeAndRecommendMusicList, likeAndRecommendMusicList)
  }

  build() {
    Column({ space: 15 }) {
      Blank()
        .height(10)
      Text('你的红心歌曲和相似推荐')
        .fontWeight(FontWeight.Bold)
        .fontSize(18)
      List() {
        ForEach(this.likeAndRecommendMusicList, (val: musicInfoModel[], index) => {
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
    }.alignItems(HorizontalAlign.Start)
  }
}