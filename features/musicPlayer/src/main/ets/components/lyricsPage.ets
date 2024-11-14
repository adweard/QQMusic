import { nameAndAuthor } from './nameAndAuthor';
import { lrcList } from './lrcList';
import { playerControllerButton } from './playerControllerButtons';


@Component
export struct lyrics {
  build() {
    Column() {
      //规避swiper
      Blank()
        .height(40)
      //页面头部歌名和作曲者
      nameAndAuthor()
      //歌词列表
      lrcList()
      Blank()
        .height(50)
      //播放控制按钮
      playerControllerButton()

    }.alignItems(HorizontalAlign.Center)
  }
}