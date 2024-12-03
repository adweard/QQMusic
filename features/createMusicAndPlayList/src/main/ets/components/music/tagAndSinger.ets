@Component
export struct tagAndSinger {
  @Consume tag: string
  @Consume singer: string
  @State index: number = 0
  @State arrowPosition: ArrowPosition = ArrowPosition.END

  build() {
    Column({ space: 30 }) {
      Row({ space: 70 }) {
        Text('选择tag')
        Select([
          { value: 'VIP' },
          { value: 'SQ' },
          { value: 'Hi-Ries' },
          { value: '超78%人播放' },
          { value: '万人评论' },
          { value: '百万红心' },
          { value: '超45%人收藏' },
          { value: '十万红心' }])
          .selected(this.index)
          .value(this.tag)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(20)
          .arrowPosition(this.arrowPosition)
          .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
          .optionWidth(200)
          .optionHeight(300)
          .onSelect((index: number, text?: string | undefined) => {
            console.info('Select:' + index)
            this.index = index;
            if (text) {
              this.tag = text;
            }
          })
      }

      TextInput({ placeholder: '输入歌手' })
        .width('80%')
        .onChange(val => {
          this.singer = val
        })
    }
  }
}