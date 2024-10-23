@Component
export struct recentlyListenedListView {
  build() {
    Column({ space: 15 }) {
      Row() {

        Text('最近常听')
          .fontWeight(FontWeight.Bold)
          .fontSize(18)

      }
    }
  }
}