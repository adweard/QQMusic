import { userInfo } from "mine/src/main/ets/model/userInfo"

export class playListModel {
  listImg: string
  listNmae: string
  listCreator: userInfo
  likeNumber: number
  commentNumber: number

  constructor(listImg: string, listNmae: string, listCreator: userInfo, likeNumber: number, commentNumber: number) {
    this.listImg = listImg
    this.listNmae = listNmae
    this.listCreator = listCreator
    this.likeNumber = likeNumber
    this.commentNumber = commentNumber
  }
}