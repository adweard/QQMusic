import { FindPage } from 'find'
import { RecommendPage } from 'recommend'
import { RadarPage } from 'radar'
import { MomentsPage } from 'moments'
import { MinePage } from 'mine'
import { window } from '@kit.ArkUI'
import { WindowManager } from '@kit.SpeechKit'


@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private tabsController = new TabsController()
  iconSizeList: number[] = [30, 35, 40, 25, 30]
  @State avoidHeight: number = 0

  aboutToAppear(): void {


  }

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedImage: Resource, unselectedImage: Resource) {
    Column() {
      Column() {
        Image(this.currentIndex == targetIndex ? selectedImage : unselectedImage)
          .size({ width: this.iconSizeList[targetIndex], height: this.iconSizeList[targetIndex] })

          .objectFit(ImageFit.Contain)
      }.size({ width: 35, height: 35 })
      .backgroundColor(this.currentIndex == targetIndex ? '#ff18ded9' : Color.Transparent)
      .borderRadius(50)
      .justifyContent(FlexAlign.Center)

      Text(title)
        .fontSize(15)
        .fontColor(this.currentIndex == targetIndex ? '#ff18ded9' : '#ff3e3d3d')
    }.onClick(() => {
      this.tabsController.changeIndex(targetIndex)
    })
  }

  build() {


    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        RecommendPage()
      }
      .tabBar(this.tabBarBuilder('推荐', 0, $r('app.media.recomend_selected'),
        $r('app.media.recommend_undeslcted')))

      TabContent() {
        FindPage()
      }.tabBar(this.tabBarBuilder('发现', 1, $r('app.media.find_selected'), $r('app.media.find_unselected')))

      TabContent() {
        RadarPage()
      }.tabBar(this.tabBarBuilder('雷达', 2, $r('app.media.radar_selected'), $r('app.media.radar_unselected')))

      TabContent() {
        MomentsPage()
      }.tabBar(this.tabBarBuilder('时刻', 3, $r('app.media.moments_selected'), $r('app.media.moments_unselected')))

      TabContent() {
        MinePage()
      }.tabBar(this.tabBarBuilder('我的', 4, $r('app.media.mine_selected'), $r('app.media.mine_unselected')))
    }
    .margin({ bottom: Number(AppStorage.get('bottomHeight')) })
    .backgroundColor('#FCFDFF')
    .divider({
      strokeWidth: 0.25,
      color: '#ff5a5a5a'
    })
    .scrollable(false)
    .onAnimationStart((Index, targetIndex) => {
      this.currentIndex = targetIndex
    })
    .animationDuration(1)

  }
}