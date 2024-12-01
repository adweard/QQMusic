import { cloudDatabase } from '@kit.CloudFoundationKit';

class UserInfo extends cloudDatabase.DatabaseObject {
  public naturalbase_ClassName(): string {
    return "UserInfo";
  }

  public UUID: string | undefined;
  public musicListArr: string | undefined;
  public like: number | undefined;
  public follower: number | undefined;
  public level: number | undefined;
  public regDuration: string | undefined;
}

export { UserInfo };