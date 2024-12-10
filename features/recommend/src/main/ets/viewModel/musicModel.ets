import { LrcEntry } from 'musicplayer/src/main/ets/Entry'
import { musicInfoModel } from './musicInfoModel'

export class musicModel {
  Info: musicInfoModel
  musicRawFile: string
  likeNumber: number
  commentNumber: number
  lrcEntry: LrcEntry[] = []

  constructor(Info: musicInfoModel, musicRawFile: string, likeNumber: number, commentNumber: number,
    lrcEntry?: LrcEntry[]) {
    this.Info = Info
    this.musicRawFile = musicRawFile
    this.likeNumber = likeNumber
    this.commentNumber = commentNumber
    if (lrcEntry) {
      this.lrcEntry = lrcEntry
    }
  }
}

export const RammsteinList: musicModel[] = [
  new musicModel(new musicInfoModel('Ich will', 'app.media.p1', 'Rammstein', false, '沉浸声', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40',
    13232, 1515),
  new musicModel(new musicInfoModel('Eifersucht', 'app.media.p2', 'Rammstein', false, '沉浸声', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fhuanghun.mp3?token=8fc9354b-973a-4664-805a-b8c6135ff22b',
    54,
    256),
  new musicModel(new musicInfoModel('Links 2 3 4', 'app.media.p3', 'Rammstein', false, '沉浸声', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243',
    951, 98),
  new musicModel(new musicInfoModel('Strib Nicht Vor Mir (Don\'t Die Before I Do)', 'app.media.p1', 'Rammstein', false,
    'VIP', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fyintiankuaile.mp3?token=34c52bbc-8ab5-4823-afa3-de744a0ec0cc',
    1, 89),
  new musicModel(new musicInfoModel('Du Hast', 'app.media.p2', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40',
    89, 498),
  new musicModel(new musicInfoModel('Amerika', 'app.media.p3', 'Rammstein', false, '沉浸声', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fshengdanjie.mp3?token=990c7971-bb6e-4ae2-9483-9332a32f93b1',
    19,
    8),
  new musicModel(new musicInfoModel('Sehnsucht', 'app.media.p1', 'Rammstein', false, '杜比', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40',
    195, 19),
  new musicModel(new musicInfoModel('Engel', 'app.media.p2', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fhuanghun.mp3?token=8fc9354b-973a-4664-805a-b8c6135ff22b',
    198,
    198),
  new musicModel(new musicInfoModel('Mutter', 'app.media.p3', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243',
    925, 129),
  new musicModel(new musicInfoModel('Asche zu Asche', 'app.media.p1', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243',
    95, 295),
  new musicModel(new musicInfoModel('Spieluhr', 'app.media.p2', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fyintiankuaile.mp3?token=34c52bbc-8ab5-4823-afa3-de744a0ec0cc',
    295, 295),
  new musicModel(new musicInfoModel('Rosenrot', 'app.media.p3', 'Rammstein/Northern Life', false, 'SQ', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fshengdanjie.mp3?token=990c7971-bb6e-4ae2-9483-9332a32f93b1',
    14, 14),
  new musicModel(new musicInfoModel('Buck dich', 'app.media.p1', 'Rammstein', false, '杜比', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40',
    184, 295295),
  new musicModel(new musicInfoModel('Spiel mich', 'app.media.p2', 'Rammstein', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fhuanghun.mp3?token=8fc9354b-973a-4664-805a-b8c6135ff22b',
    52, 29),
  new musicModel(new musicInfoModel('Fade To Black', 'app.media.p3', 'Metallica', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243',
    582, 295259),
  new musicModel(new musicInfoModel('Enter Sandman', 'app.media.p1', 'Metallica', false, '超清母带', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fyintiankuaile.mp3?token=34c52bbc-8ab5-4823-afa3-de744a0ec0cc',
    295, 298),
  new musicModel(new musicInfoModel('The Unforgiven', 'app.media.p2', 'Metallica', false, 'VIP', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fshengdanjie.mp3?token=990c7971-bb6e-4ae2-9483-9332a32f93b1',
    985, 298),
  new musicModel(new musicInfoModel('Master of Puppets', 'app.media.p3', 'Metallica', false, 'VIP', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Ffushishanxia.mp3?token=89cf5d82-0ee2-4187-a8bc-b1f06f85bd40',
    25529, 52),
  new musicModel(new musicInfoModel('The Unforgiven II', 'app.media.p1', 'Metallica', false, 'VIP', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fhuanghun.mp3?token=8fc9354b-973a-4664-805a-b8c6135ff22b',
    9524, 1482),
  new musicModel(new musicInfoModel('One', 'app.media.p2', 'Metallica', false, 'VIP', ''),
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/default-bucket-0ji5c/music%2Fqinghua.mp3?token=92b7005d-4776-434b-ab53-5771c2321243',
    278239, 45),

]