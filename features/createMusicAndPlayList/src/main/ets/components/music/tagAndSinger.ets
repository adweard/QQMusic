@Component
export struct tagAndSinger {
  @Consume tag: string
  @Consume singer: string
  @State index: number = 0
  @State index2: number = 0
  @State index3: number = 0
  @State arrowPosition: ArrowPosition = ArrowPosition.END
  @Consume isLike: boolean
  @Consume musicURL: string
  @State showMusic: string = ''
  @Consume realMusicName: string

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

      Row({ space: 70 }) {
        Text('选择歌手')
        Select([
          { value: '陈奕迅' },
          { value: '薛之谦' },
          { value: 'Rammstein' },
          { value: 'Rammstein/NorthernLife' },
          { value: 'Metallica' },
          { value: '李荣浩' },
          { value: '蔡依林' },
          { value: '王菲' },
          { value: '卢广仲' },
          { value: '杨丞琳' },
          { value: '方大同' },
          { value: '邓丽君' },
          { value: '陈奕迅/AGA' },
          { value: '草蜢' }])
          .selected(this.index)
          .value(this.singer)
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
            this.index2 = index;
            if (text) {
              this.singer = text;
            }
          })
      }

      Row({ space: 70 }) {
        Text('是否收藏')
        Select([
          { value: 'true' },
          { value: 'false' }])
          .selected(this.index)
          .value(String(this.isLike))
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
            if (text == 'false') {
              this.isLike = false
            } else {
              this.isLike = true
            }
          })
      }

      Row({ space: 70 }) {
        Text('选歌')
        Select([
          { value: '富士山下' },
          { value: '青花' },
          { value: '阴天快乐' },
          { value: '圣诞结' }])
          .selected(this.index)
          .value(this.showMusic)
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
            if (text == '富士山下') {
              this.showMusic = text
              this.realMusicName = text
              this.musicURL =
                'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40'
            } else if (text == '青花') {
              this.showMusic = text
              this.realMusicName = text
              this.musicURL =
                'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243'
            } else if (text == '阴天快乐') {
              this.showMusic = text
              this.realMusicName = text
              this.musicURL =
                'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fyintiankuaile.mp3?token=2f50a721-d41b-4313-86ba-c56940ad9535'
            } else if (text == '圣诞结') {
              this.showMusic = text
              this.realMusicName = text
              this.musicURL =
                'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fshengdanjie.mp3?token=990c7971-bb6e-4ae2-9483-9332a32f93b1'
            }
          })
      }
    }
  }
}