import { media } from '@kit.MediaKit';
import { MusicPlayMode } from 'mediacommon';
import { playListModel } from "recommend"
import { util } from '@kit.ArkTS';
import { getRandomInt } from 'recommend/src/main/ets/utils/getRandomInt';

class MusicPlayer {
  private avPlayer: media.AVPlayer | null = null
  private loop: boolean = false
  public isPlaying: boolean = false

  async getAVPlayerInstance() {
    // 如果已存在，直接返回
    if (this.avPlayer !== null) {
      return this.avPlayer
    }
    // 初始化播放器
    const player = await media.createAVPlayer()
    player.on('stateChange', (state) => {
      switch (state) {
        case 'initialized':
          player.prepare()
          break;
        case 'prepared':
          player.play()
          break;
        case 'playing':
          player.play()
          if (AppStorage.get('reStart') == true) {
            player.seek(AppStorage.get('preSeek'))
            player.pause()
            AppStorage.setOrCreate('reStart', false)
          }
          this.isPlaying = true
          AppStorage.setOrCreate('isPlaying', this.isPlaying)
          break;
        case 'paused':
          player.pause()
          this.isPlaying = false
          AppStorage.setOrCreate('isPlaying', this.isPlaying)
          break;
        case 'completed':
          switch (AppStorage.get('playMode') as Number) {
            case (MusicPlayMode.SINGLE_CYCLE):
              player.play()
              break
            case (MusicPlayMode.ORDER):
              this.playNext()
              break
            case (MusicPlayMode.RANDOM):
              let playList: playListModel = AppStorage.get('playList') as playListModel
              let len = playList.musicList.length
              let t = getRandomInt(0, len - 1)
              while (t == AppStorage.get('playIndex') || t > len - 1 || t < 0) {
                t = getRandomInt(0, len)
              }
              this.playByRawSrc(playList.musicList[t].musicRawFile).then(player => {
                AppStorage.setOrCreate('player', player)
              })
              AppStorage.setOrCreate('playIndex', t)
              AppStorage.setOrCreate('playMusic', playList.musicList[t])


          }

          break;
        case 'stopped':
          player.reset() // stop 时 reset -> 释放音频资源
          break;
        default:
          break;
      }
    })
    this.avPlayer = player
    return this.avPlayer
  }

  // 加载 src/main/resources/rawfile 的文件
  async playByRawSrc(rawFdPath: string): Promise<media.AVPlayer> {
    const player = await this.getAVPlayerInstance()
    // 先释放原来的资源
    await player.reset()
    // 获取文件信息
    const context = getContext()
    // 加载 src/main/resources/rawfile 文件夹中的文件
    const fileDescriptor = await context.resourceManager.getRawFd(rawFdPath)
    // 设置播放路径
    player.fdSrc = fileDescriptor
    // 播放
    player.play()

    player.on('timeUpdate', (val) => {
      AppStorage.setOrCreate('seek', val)
    })
    return player

  }

  // 加载 src/main/resources/rawfile 的文件
  async rePlayByRawSrc(rawFdPath: string): Promise<media.AVPlayer> {
    const reSeek = AppStorage.get('seek') as number
    console.log('获取，在创建对象时获取的seek', reSeek.toString())
    const player = await this.getAVPlayerInstance()
    // 先释放原来的资源
    // await player.reset()
    // 获取文件信息
    const context = getContext()
    // 加载 src/main/resources/rawfile 文件夹中的文件
    const fileDescriptor = await context.resourceManager.getRawFd(rawFdPath)
    // 设置播放路径
    player.fdSrc = fileDescriptor
    player.on('seekDone', val => {
      console.log('seekDone 跳转成功' + val)
    })
    // 播放
    player.pause()

    player.on('timeUpdate', (val) => {
      AppStorage.setOrCreate('seek', val)
    })

    return player

  }

  // 停止播放
  async stop() {
    const player = await this.getAVPlayerInstance()
    this.loop = false
    player.stop()
  }

  // 设置循环播放
  async setLoop(isLoop: boolean) {
    this.loop = isLoop
  }

  playNext() {
    let playList: playListModel = AppStorage.get('playList') as playListModel
    let playIndex: number = AppStorage.get('playIndex') as number
    if (playIndex == playList.musicList.length - 1) {
      this.playByRawSrc(playList.musicList[0].musicRawFile)
      AppStorage.setOrCreate('playIndex', 0)
      AppStorage.setOrCreate('playMusic', playList.musicList[0])
    } else {
      this.playByRawSrc(playList.musicList[playIndex+1].musicRawFile)
      AppStorage.setOrCreate('playIndex', playIndex + 1)
      AppStorage.setOrCreate('playMusic', playList.musicList[playIndex + 1])
    }
  }

  playBefore() {
    let playlist: playListModel = AppStorage.get('playList') as playListModel
    let playIndex: number = AppStorage.get('playIndex') as number
    if (playIndex == 0) {
      this.playByRawSrc(playlist.musicList[playlist.musicList.length-1].musicRawFile)
      AppStorage.setOrCreate('playMusic', playlist.musicList[playlist.musicList.length-1])
      AppStorage.setOrCreate('playIndex', playlist.musicList.length - 1)

    } else {
      this.playByRawSrc(playlist.musicList[playIndex-1].musicRawFile)
      AppStorage.setOrCreate('playMusic', playlist.musicList[playIndex - 1])
      AppStorage.setOrCreate('playIndex', playIndex - 1)

    }
  }
}

export const musicPlayer = new MusicPlayer()
