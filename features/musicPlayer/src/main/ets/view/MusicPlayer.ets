import { musicModel } from "recommend/src/main/ets/viewModel/musicModel";
import { header } from "../components/header";
import { lyrics } from "../components/lyricsPage";
import { musicInfoPage } from "../components/MusicInfoPage";
import { lycModel } from "../utils/lycUtil";

@Component
export struct MusicPlayerPage {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  @State param: musicModel[] = this.pageIndexInfos.getParamByName('musicPlayer') as musicModel[]
  @Provide musicInfo: musicModel = this.param[0]

  aboutToAppear(): void {
    this.musicInfo.lrcEntry = lycModel.getLycFile(this.musicInfo.musicRawFile)
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
    // .backgroundColor('#ff530606')
    .backgroundImage($r(this.musicInfo.Info.img))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundBlurStyle(BlurStyle.BACKGROUND_ULTRA_THICK)

    .height('100%')
    .width('100%')
    .alignContent(Alignment.Top)

  }
}
