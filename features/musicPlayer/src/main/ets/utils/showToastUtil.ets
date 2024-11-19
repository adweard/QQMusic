import { promptAction } from '@kit.ArkUI';

class ShowToast {
  private longToastTime: number = 3000;
  private shortToastTime: number = 1000;

  showToast(message: ResourceStr, duration: number) {
    promptAction.showToast({ message: message, duration: duration });
  }

  shortToast(message: ResourceStr) {
    this.showToast(message, this.shortToastTime);
  }

  longToast(message: ResourceStr) {
    this.showToast(message, this.longToastTime);
  }
}

export default new ShowToast();