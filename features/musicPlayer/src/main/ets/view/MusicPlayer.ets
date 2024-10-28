import { musicModel } from "recommend/src/main/ets/viewModel/musicModel";
import { header } from "../components/header";
import { lyrics } from "../components/lyricsPage";
import { musicInfoPage } from "../components/MusicInfoPage";


@Component
export struct MusicPlayerPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  @State message: string = 'Hello World';
  @State param: musicModel[] = this.pageIndexInfos.getParamByName('musicPlayer') as musicModel[]
  @Provide musicInfo: musicModel = this.param[0]

  aboutToAppear(): void {
    console.log("测试播放" + this.musicInfo.Info.name + '   ' + this.musicInfo.Info.img)
  }

  build() {
    Stack() {

      Swiper() {
        musicInfoPage()
        lyrics()
      }
      .loop(false)
      .indicator(
        new DotIndicator()
          .top($r(AppStorage.get('topHeight')))
          .selectedColor('#ffeaeaea')
          .color('#ff000000')
      )
      .padding({ top: Number(AppStorage.get('topHeight')), bottom: Number(AppStorage.get('bottomHeight')) })
      .height('100%')
      .width('100%')

      header()
        .padding({ top: Number(AppStorage.get('topHeight')) })
    }
    .backgroundColor('#ff530606')
    .height('100%')
    .width('100%')
    .alignContent(Alignment.Top)

  }
}
