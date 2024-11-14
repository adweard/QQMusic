import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { playListModelList } from 'recommend';
import { musicPlayer } from 'musicplayer/src/main/ets/utils/MusicPlayerUtil';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    AppStorage.setOrCreate('context', this.context)
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.getMainWindow().then(win => {
      win.setWindowLayoutFullScreen(true)
      PersistentStorage.persistProp('topHeight',
        px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height))
      PersistentStorage.persistProp('bottomHeight',
        px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height))
    })

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      PersistentStorage.persistProp('playListIndex', undefined)
      PersistentStorage.persistProp('playIndex', undefined)
      PersistentStorage.persistProp('seek', undefined)
      AppStorage.setOrCreate('preSeek', AppStorage.get('seek'))
      if (typeof AppStorage.get('playIndex') == 'undefined') {
        //播放列表不存在
      } else {
        //播放列表存在
        let preSeek = AppStorage.get('preSeek') as number
        let playListIndex = AppStorage.get('playListIndex') as number
        AppStorage.setOrCreate('playList', playListModelList[playListIndex])
        let playIndex = AppStorage.get('playIndex') as number
        AppStorage.setOrCreate('playMusic', playListModelList[playListIndex].musicList[playIndex])
        AppStorage.setOrCreate('reStart',true)
        musicPlayer.rePlayByRawSrc(playListModelList[playListIndex].musicList[playIndex].musicRawFile)
          .then((player) => {
            player.pause()
            AppStorage.setOrCreate('player', player)

          })
      }


      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');


    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
