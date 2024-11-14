import { util } from "@kit.ArkTS";
import { LrcEntry } from "../Entry";
import { Context } from "@kit.AbilityKit";

class LycModel {
  private context: Context = AppStorage.get('context') as Context
  private lrcEntryList: LrcEntry[] = []

  getLycFile(songName: string): LrcEntry[] {
    if (songName == 'fushishanxia.mp3') {
      //歌是富士山下
      let file = this.context.resourceManager.getRawFileContentSync('fushishanxia.lrc')
      this.lrcEntryList = this.getLrcList(file)
    } else {
      //歌是黄昏
      let file = this.context.resourceManager.getRawFileContentSync('huanghun.lrc')
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