import { media } from '@kit.MediaKit';

@Component
export struct playbackProgress {
  private player: media.AVPlayer = AppStorage.get("player") as media.AVPlayer
  @State musicDuration: number = 0
  @State musicUpdateTime: number = 0
  @State updateTime: string = '00:00'
  @State durationTime: string = '00:00'
  @StorageLink('seek') @Watch('onTimeChange') seek: number = 0
  interval: number = 0

  aboutToAppear(): void {
    console.log('测试' + typeof (AppStorage.get("player")))
    console.log('测试 是否有对象' + typeof (this.player))
    this.musicDuration = this.player.duration
    this.durationTime = this.getTime(this.player.duration)
    this.player.on('durationUpdate', (val) => {
      this.musicDuration = val
      this.durationTime = this.getTime(val)

      //倒计时
      this.interval = setInterval(() => {
        if (this.player != null)
        {
          //清除定时器
          clearInterval(this.interval)
          return
        }
        this.player = AppStorage.get('player') as media.AVPlayer
      }, 1000)
    })


  }

  build() {
    Column() {
      Slider({ max: this.musicDuration, style: SliderStyle.NONE, value: $$this.musicUpdateTime })
        .selectedColor('#ffff')
        .onChange(val => {
          this.player.seek(val, media.SeekMode.SEEK_CLOSEST)
        })

        .width('100%')
      Row() {
        Text(this.updateTime)
          .fontSize(10)
          .fontColor('#ffff')
        Text(this.durationTime)
          .fontSize(10)
          .fontColor('#ffff')

      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

    }.width('90%')
  }

  getTime(seconds: number): string {
    const hours = Math.floor(seconds / 3600000);
    const minutes = Math.floor((seconds % 3600000) / 60000);
    const sec = (seconds % 60000) / 1000;
    // 将小时、分钟和秒转换为两位数格式
    const formattedHours = hours.toString().padStart(2, '0');
    const formattedMinutes = minutes.toString().padStart(2, '0');
    let formattedSeconds = '00'
    if (sec < 10) {
      formattedSeconds = '0' + sec.toString().split('.')[0]
    } else {
      formattedSeconds = sec.toString().padStart(2, '0');
      formattedSeconds = formattedSeconds.split('.')[0]
    }
    if (formattedHours == '00') {
      return `${formattedMinutes}:${formattedSeconds}`
    }
    return `${formattedHours}:${formattedMinutes}:${formattedSeconds}`;
  }

  onTimeChange() {
    this.musicUpdateTime = this.seek
    this.updateTime = this.getTime(this.musicUpdateTime)
  }
}