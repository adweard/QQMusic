import { userInfo, UserInfoList } from "mine/src/main/ets/model/userInfo"

export class playListModel {
  listImg: string
  imgName: string
  layoutColor:string[] = ['','']
  listName: string
  listCreator: userInfo
  likeNumber: number
  commentNumber: number

  constructor(listImg: string, imgName: string, listName: string, listCreator: userInfo, likeNumber: number,
    commentNumber: number) {
    this.listImg = listImg
    this.imgName = imgName
    this.listName = listName
    this.listCreator = listCreator
    this.likeNumber = likeNumber
    this.commentNumber = commentNumber
  }
}

export const playListModelList: playListModel[] = [
  new playListModel('app.media.p1', 'p1.jpg', '金属 战车 曼森 合集', UserInfoList[0], 1150, 888),
  new playListModel('app.media.p2', 'p2.jpg', '你的红心歌曲和相似推荐', UserInfoList[0], 1150, 888),
  new playListModel('app.media.p3', 'p3.jpg', '红心歌单', UserInfoList[0], 1150, 888),
  new playListModel('app.media.p1', 'p1.jpg', '薛之谦', UserInfoList[0], 1150, 888),
  new playListModel('app.media.p2', 'p2.jpg', '陈奕迅', UserInfoList[0], 1150, 888),
  new playListModel('app.media.p3', 'p3.jpg', '林俊杰 JJ', UserInfoList[0], 1150, 888)
]