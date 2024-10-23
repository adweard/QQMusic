import { musicInfoModel } from "../model/musicInfoModel"

//一维数组分组为等长二维数组
export function orderList(listen: musicInfoModel[][], list: musicInfoModel[]) {
  //将红心和相似歌曲分组
  // console.log('测试------------------------------------------------------------------------------------------')
  for (let i = 0; i < list.length / 3; i++) {
    // this.likeAndRecommendMusicList[i] = []
    listen[i] = []
    for (let t = 0; t < 3; t++) {
      // this.likeAndRecommendMusicList[i][t] = likeAndRecommendMusicList[i * 3+t]
      listen[i][t] = list[i * 3 +t]

      // console.log('测试' + listin[i][t].name)

    }

  }

}