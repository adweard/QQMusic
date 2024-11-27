export class userInfo {
  private _userName: string

  public set userName(value: string) {
    this._userName = value
  }

  public get userName(): string {
    return this._userName
  }

  private _userAvatar: Resource

  public set userAvatar(value: Resource) {
    this._userAvatar = value
  }

  public get userAvatar(): Resource {
    return this._userAvatar
  }

  private _locate: string = '陕西 西安'

  public set locate(value: string) {
    this._locate = value
  }

  public get locate(): string {
    return this._locate
  }

  private _joinDuration: string = '3年'

  public set joinDuration(value: string) {
    this._joinDuration = value
  }

  public get joinDuration(): string {
    return this._joinDuration
  }

  private _focus: number = 0

  public set focus(value: number) {
    this._focus = value
  }

  public get focus(): number {
    return this._focus
  }

  private _follower: number = 0

  public set follower(value: number) {
    this._follower = value
  }

  public get follower(): number {
    return this._follower
  }

  private _level: number = 0

  public set level(value: number) {
    this._level = value
  }

  public get level(): number {
    return this._level
  }

  constructor(userName: string, userAvatar: Resource, locate?: string, joinDuration?: string, focus?: number,
    follower?: number, level?: number) {
    this._userName = userName
    this._userAvatar = userAvatar
    if (locate) {
      this._locate = this._locate
    }
    if (joinDuration) {
      this._joinDuration = joinDuration
    }
    if (focus) {
      this._focus = focus
    }
    if (follower) {
      this._follower = follower
    }
    if (level) {
      this._level = level
    }
  }
}

export const UserInfoList: userInfo[] = [
  new userInfo('Cary_cacb', $r('app.media.avatar1'),),
  new userInfo('曲终の人散', $r('app.media.avatar2')),
  new userInfo('大神级土豪', $r('app.media.avatar3')),
  new userInfo('穿越火线高手', $r('app.media.avatar4')),
  new userInfo('DC大公公', $r('app.media.avatar5')),
  new userInfo('Faker', $r('app.media.avatar6')),
  new userInfo('bin', $r('app.media.avatar7')),
  new userInfo('369', $r('app.media.avatar8'))

]