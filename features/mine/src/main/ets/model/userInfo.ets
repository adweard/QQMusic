export class userInfo {
  userName: string
  userAvatar: Resource

  constructor(userName: string, userAvatar: Resource) {
    this.userName = userName
    this.userAvatar = userAvatar
  }
}

export const UserInfoList: userInfo[] = [
  new userInfo('Cary_cacb', $r('app.media.avatar1')),
  new userInfo('曲终の人散', $r('app.media.avatar2')),
  new userInfo('大神级土豪', $r('app.media.avatar3')),
  new userInfo('穿越火线高手', $r('app.media.avatar4')),
  new userInfo('DC大公公', $r('app.media.avatar5')),
  new userInfo('Faker', $r('app.media.avatar6')),
  new userInfo('bin', $r('app.media.avatar7')),
  new userInfo('369', $r('app.media.avatar8'))

]