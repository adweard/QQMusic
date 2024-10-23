@Observed
export class recommendListModel {
  title: string
  img: string
  msg: string
  imgName: string
  overlayColor: string[] = []

  constructor(title: string, img: string, msg: string, imgName: string, overlayColor?: string[]) {
    this.title = title
    this.img = img
    this.msg = msg
    this.imgName = imgName
    if (overlayColor) {
      this.overlayColor = overlayColor
    }
  }
}


export const List_1: recommendListModel[] =
  [
    new recommendListModel('每日推荐', 'app.media.p1', '符合你口味的新鲜好歌', 'p1.jpg'),
    new recommendListModel('私人漫游', 'app.media.p2', '多种听歌模式随心播放', 'p2.jpg'),
    new recommendListModel('心动模式', 'app.media.p3', '红心歌曲和相似推荐', 'p3.jpg'),
    new recommendListModel('私人雷达', 'app.media.p2', '你爱的歌值得反复聆听', 'p2.jpg'),
    new recommendListModel('相似歌曲', 'app.media.p3', '从你喜欢的歌听起', 'p3.jpg'),
    new recommendListModel('相似艺人', 'app.media.p4', '从你喜欢的艺人听起', 'p4.jpg'),
  ]
