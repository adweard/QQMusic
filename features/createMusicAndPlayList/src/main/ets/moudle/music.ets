import { cloudDatabase } from '@kit.CloudFoundationKit';

class musicInfo extends cloudDatabase.DatabaseObject {
  naturalbase_ClassName(): string {
    return "musicInfo";
  }

  musicURL: string | undefined
  cover: string | undefined
  name: string | undefined
  tag: string | undefined
  singer: string | undefined
  trueName: string | undefined
  isLike: boolean | undefined
}

export { musicInfo };