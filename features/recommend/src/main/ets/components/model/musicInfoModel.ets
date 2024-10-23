export class musicInfoModel {
  name: string
  img: string
  singer: string
  like: boolean
  info: string
  imgName:string
  overlayColor:string[] = []


  constructor(name: string, img: string, singer: string, like: boolean, info: string,imgName:string) {
    this.name = name
    this.img = img
    this.singer = singer
    this.like = like
    this.info = info
    this.imgName = imgName
  }
}

export const likeAndRecommendMusicList: musicInfoModel[] =
  [new musicInfoModel('Special One', 'app.media.p2', 'AGA/陈奕迅', true, 'Hi-Res','p1.jpg'),
    new musicInfoModel('黑洞', 'app.media.p3', '陈奕迅', false, 'VIP','p3.jpg'),
    new musicInfoModel('富士山下', 'app.media.p4', '陈奕迅', true, 'VIP','p4.jpg'),
    new musicInfoModel('谁来剪月光', 'app.media.p2', '陈奕迅', true, 'VIP','p2.jpg'),
    new musicInfoModel('内疚', 'app.media.p3', '陈奕迅', false, 'SQ','p3.jpg'),
    new musicInfoModel('可一可再', 'app.media.p4', '陈奕迅/eason and the duo band', false, 'Hi-Res','p4.jpg'),
    new musicInfoModel('单车', 'app.media.p4', '陈奕迅', true, 'VIP','p4.jpg'),
    new musicInfoModel('不说', 'app.media.p4', '李荣浩', false, 'SQ','p4.jpg'),
    new musicInfoModel('葡萄成熟时', 'app.media.p4', '陈奕迅', true, 'SQ','p4.jpg'),
  ]

export const suggestMusicList: musicInfoModel[][] = [
  [new musicInfoModel('打回原形', 'app.media.p2', '陈奕迅', false, '超78%人播放','p2.jpg'),
    new musicInfoModel('老伴', 'app.media.p3', '李荣浩', false, '万人评论','p3.jpg'),
    new musicInfoModel('我知道你很难过', 'app.media.p4', '蔡依林', false, 'VIP','p4.jpg'),
    new musicInfoModel('匆匆那年', 'app.media.p2', '王菲', false, '万人评论','p2.jpg'),
    new musicInfoModel('刻在我心底的名字', 'app.media.p3', '卢广仲', false, '百万红心','p3.jpg'),
    new musicInfoModel('带我走', 'app.media.p4', '杨丞琳', false, 'SQ','p4.jpg'),
    new musicInfoModel('半点心', 'app.media.p4', '草蜢', false, 'VIP','p4.jpg'),
    new musicInfoModel('没啥好说', 'app.media.p4', '方大同', false, '超45%人收藏','p4.jpg'),
    new musicInfoModel('我只在乎你', 'app.media.p4', '邓丽君', false, '十万红心','p4.jpg'),],

  [new musicInfoModel('雅俗共赏(Live)', 'app.media.p2', '许嵩', false, '超80%人播放','p2.jpg'),
    new musicInfoModel('十年', 'app.media.p3', '陈奕迅', false, '昨日十万播放','p3.jpg'),
    new musicInfoModel('奇妙能力歌', 'app.media.p4', '陈粒', false, '','p4.jpg'),
    new musicInfoModel('一样的月光', 'app.media.p2', '徐佳莹', false, '昨日万人播放','p2.jpg'),
    new musicInfoModel('一直很安静(Live版)', 'app.media.p3', '毛不易', false, 'Hi-Rise','p3.jpg'),
    new musicInfoModel('红豆', 'app.media.p4', '王菲', false, 'VIP','p4.jpg'),
    new musicInfoModel('贝加尔湖畔', 'app.media.p4', '李健', false, '昨日十万播放','p4.jpg'),
    new musicInfoModel('倔强', 'app.media.p4', '五月天', false, '第三节Hito流行音乐奖','p4.jpg'),
    new musicInfoModel('其实都没有', 'app.media.p4', '杨宗纬/杨旭', false, 'VIP','p4.jpg'),],

  [new musicInfoModel('倒带', 'app.media.p2', '蔡依林', false, '超74%人播放','p2.jpg'),
    new musicInfoModel('还记得', 'app.media.p3', '周伯豪', false, '万人评论','p3.jpg'),
    new musicInfoModel('习惯失恋', 'app.media.p4', '容祖儿', false, 'VIP','p4.jpg'),
    new musicInfoModel('爱得太迟', 'app.media.p2', '古巨基', false, '昨日万人播放','p2.jpg'),
    new musicInfoModel('到此为止', 'app.media.p3', '连诗雅', false, '百万红心','p3.jpg'),
    new musicInfoModel('无赖', 'app.media.p4', '郑中基', false, 'VIP','p4.jpg'),
    new musicInfoModel('灰姑娘', 'app.media.p4', '梁咏琪', false, '昨日十万播放','p4.jpg'),
    new musicInfoModel('不浪漫罪名', 'app.media.p4', '王杰', false, 'VIP','p4.jpg'),
    new musicInfoModel('相依为命', 'app.media.p4', '陈小春', false, 'VIP','p4.jpg'),],

  [new musicInfoModel('你过得好吗', 'app.media.p2', '薛之谦', false, '超78%人播放','p2.jpg'),
    new musicInfoModel('你还要我怎样(Live)', 'app.media.p3', '薛之谦', false, '昨日万人播放','p3.jpg'),
    new musicInfoModel('戒烟', 'app.media.p4', '李荣浩', false, 'VIP','p4.jpg'),
    new musicInfoModel('平凡的一天', 'app.media.p2', '毛不易', false, '昨日十万播放','p2.jpg'),
    new musicInfoModel('当你', 'app.media.p3', '林俊杰', false, '万人评论','p3.jpg'),
    new musicInfoModel('天若有情', 'app.media.p4', '黄丽玲', false, 'VIP','p4.jpg'),
    new musicInfoModel('无人之岛', 'app.media.p4', '任然', false, '十万评论','p4.jpg'),
    new musicInfoModel('夏夜最后的烟火', 'app.media.p4', '颜人中', false, '百万红心','p4.jpg'),
    new musicInfoModel('盛夏的果实', 'app.media.p4', '莫文蔚', false, 'VIP','p4.jpg'),],

  [new musicInfoModel('猜情寻', 'app.media.p2', '陈奕迅', false, 'VIP','p2.jpg'),
    new musicInfoModel('孤勇者', 'app.media.p3', '陈奕迅', false, 'VIP','p3.jpg'),
    new musicInfoModel('打回原形', 'app.media.p4', '陈奕迅', false, 'VIP','p4.jpg'),
    new musicInfoModel('约定(Live)', 'app.media.p2', '陈奕迅', false, 'VIP','p2.jpg'),
    new musicInfoModel('内疚', 'app.media.p3', '陈奕迅', false, 'SQ','p3.jpg'),
    new musicInfoModel('喜帖街(Live)', 'app.media.p4', '陈奕迅', false, 'VIP','p4.jpg'),
    new musicInfoModel('黑暗中漫舞', 'app.media.p4', '陈奕迅', false, 'VIP','p4.jpg'),
    new musicInfoModel('无条件', 'app.media.p4', '陈奕迅', false, 'VIP','p4.jpg'),
    new musicInfoModel('绵绵', 'app.media.p4', '陈奕迅', false, 'VIP','p4.jpg'),]
]