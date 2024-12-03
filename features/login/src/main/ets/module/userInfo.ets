import { cloudDatabase } from '@kit.CloudFoundationKit';

class userInfo extends cloudDatabase.DatabaseObject {
  public naturalbase_ClassName(): string {
    return "userInfo";
  }

  public UUID: string | undefined;
  public musicListArr: string | undefined;
  public like: number | undefined;
  public follower: number | undefined;
  public level: number | undefined;
  public regDuration: string | undefined;
  public name: string | undefined;
  public avatar: string | undefined;
}

export { userInfo };