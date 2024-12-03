@Component
export struct createPlayListPage{
  build() {
    Column(){

    }
    .width('100%')
    .height('100%')
    .padding({ top: Number(AppStorage.get('topHeight')) })
  }
}