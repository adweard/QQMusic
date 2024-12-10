import { util } from "@kit.ArkTS";
import { LrcEntry } from "../Entry";
import { Context } from "@kit.AbilityKit";

class LycModel {
  private context: Context = AppStorage.get('context') as Context
  private lrcEntryList: LrcEntry[] = []

  getLycFile(songName: string): LrcEntry[] {
    if (songName ==
      'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40') {
      //歌是富士山下
      let file = this.context.resourceManager.getRawFileContentSync('fushishanxia.lrc')
      this.lrcEntryList = this.getLrcList(file)
    } else if (songName ==
      'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fhuanghun.mp3?token=8fc9354b-973a-4664-805a-b8c6135ff22b') {
      //歌是黄昏
      let file = this.context.resourceManager.getRawFileContentSync('huanghun.lrc')
      this.lrcEntryList = this.getLrcList(file)
    } else if (songName ==
      'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243') {
      //歌是青花
      let file = this.context.resourceManager.getRawFileContentSync('qinghua.lrc')
      this.lrcEntryList = this.getLrcList(file)
    } else if (songName ==
      'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fyintiankuaile.mp3?token=34c52bbc-8ab5-4823-afa3-de744a0ec0cc') {
      //歌是阴天快乐
      let file = this.context.resourceManager.getRawFileContentSync('yintiankuaile.lrc')
      this.lrcEntryList = this.getLrcList(file)
    } else if (songName ==
      'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fshengdanjie.mp3?token=990c7971-bb6e-4ae2-9483-9332a32f93b1') {
      //歌是圣诞结
      let file = this.context.resourceManager.getRawFileContentSync('shengdanjie.lrc')
      this.lrcEntryList = this.getLrcList(file)
    }
    return this.lrcEntryList
  }

  getLrcList(file: Uint8Array): Array<LrcEntry> {
    let textDecoder = util.TextDecoder.create('utf-8');
    let stringData = textDecoder.decodeToString(file);
    let lrc = new Array<LrcEntry>();
    let lrcList = stringData.split('\n')
    const lrcLineRegex: RegExp = new RegExp('\\[\\d{2,}\\s?:\\s?\\d{2}((\\.|:)\\d{2,})\\]', 'g');
    const lrcTimeRegex1: RegExp = new RegExp('\\[\\d{2,}\\s?', 'i');
    const lrcTimeRegex2: RegExp = new RegExp('\\d{2}\\.\\d{2,}', 'i');
    for (let i = 0; i < lrcList.length; i++) {
      let lineTime = lrcList[i].match(lrcLineRegex);
      let lineText = lrcList[i].replace(lrcLineRegex, '');
      if (lineTime && lineText) {
        for (let j = 0; j < lineTime.length; j++) {
          let min = Number(String(lineTime[j].match(lrcTimeRegex1)).slice(1));
          let sec = Number.parseFloat(String(lineTime[j].match(lrcTimeRegex2)));
          let timeInSeconds = (min * 60 + sec) * 1000;
          lrc.push({
            lineStartTime: timeInSeconds,
            lineDuration: 0,
            lineWords: lineText,
          });
        }
      }
    }
    if (lrc && lrc.length > 0) {
      lrc.sort((a, b) => {
        return a.lineStartTime - b.lineStartTime;
      })
      for (let i = 0; i < lrc.length; i++) {
        if (i === lrc.length - 1) {
          lrc[i].lineDuration = Number.MAX_VALUE;
        } else {
          lrc[i].lineDuration = lrc[i+1].lineStartTime - lrc[i].lineStartTime;
        }
      }
    } else {
      console.error('Failed to parse the lyrics.');
    }
    return lrc;
  }
}

export const lycModel = new LycModel()