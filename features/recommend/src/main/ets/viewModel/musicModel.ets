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
  new musicModel(new musicInfoModel('Ich will', 'app.media.p1', 'Rammstein', false, '沉浸声', ''), 'fushishanxia.mp3',
    13232, 1515),
  new musicModel(new musicInfoModel('Eifersucht', 'app.media.p2', 'Rammstein', false, '沉浸声', ''), 'huanghun.mp3', 54,
    256),
  new musicModel(new musicInfoModel('Links 2 3 4', 'app.media.p3', 'Rammstein', false, '沉浸声', ''),
    'fushishanxia.mp3', 951, 98),
  new musicModel(new musicInfoModel('Strib Nicht Vor Mir (Don\'t Die Before I Do)', 'app.media.p1', 'Rammstein', false,
    'VIP', ''), 'huanghun.mp3', 1, 89),
  new musicModel(new musicInfoModel('Du Hast', 'app.media.p2', 'Rammstein', false, '超清母带', ''), 'fushishanxia.mp3',
    89, 498),
  new musicModel(new musicInfoModel('Amerika', 'app.media.p3', 'Rammstein', false, '沉浸声', ''), 'huanghun.mp3', 19,
    8),
  new musicModel(new musicInfoModel('Sehnsucht', 'app.media.p1', 'Rammstein', false, '杜比', ''), 'fushishanxia.mp3',
    195, 19),
  new musicModel(new musicInfoModel('Engel', 'app.media.p2', 'Rammstein', false, '超清母带', ''), 'huanghun.mp3', 198,
    198),
  new musicModel(new musicInfoModel('Mutter', 'app.media.p3', 'Rammstein', false, '超清母带', ''), 'fushishanxia.mp3',
    925, 129),
  new musicModel(new musicInfoModel('Asche zu Asche', 'app.media.p1', 'Rammstein', false, '超清母带', ''),
    'huanghun.mp3', 95, 295),
  new musicModel(new musicInfoModel('Spieluhr', 'app.media.p2', 'Rammstein', false, '超清母带', ''),
    'fushishanxia.mp3', 295, 295),
  new musicModel(new musicInfoModel('Rosenrot', 'app.media.p3', 'Rammstein/Northern Life', false, 'SQ', ''),
    'huanghun.mp3', 14, 14),
  new musicModel(new musicInfoModel('Buck dich', 'app.media.p1', 'Rammstein', false, '杜比', ''), 'fushishanxia.mp3',
    184, 295295),
  new musicModel(new musicInfoModel('Spiel mich', 'app.media.p2', 'Rammstein', false, '超清母带', ''), 'huanghun.mp3',
    52, 29),
  new musicModel(new musicInfoModel('Fade To Black', 'app.media.p3', 'Metallica', false, '超清母带', ''),
    'fushishanxia.mp3', 582, 295259),
  new musicModel(new musicInfoModel('Enter Sandman', 'app.media.p1', 'Metallica', false, '超清母带', ''),
    'huanghun.mp3', 295, 298),
  new musicModel(new musicInfoModel('The Unforgiven', 'app.media.p2', 'Metallica', false, 'VIP', ''),
    'fushishanxia.mp3', 985, 298),
  new musicModel(new musicInfoModel('Master of Puppets', 'app.media.p3', 'Metallica', false, 'VIP', ''),
    'huanghun.mp3', 25529, 52),
  new musicModel(new musicInfoModel('The Unforgiven II', 'app.media.p1', 'Metallica', false, 'VIP', ''),
    'fushishanxia.mp3', 9524, 1482),
  new musicModel(new musicInfoModel('One', 'app.media.p2', 'Metallica', false, 'VIP', ''), 'huanghun.mp3', 278239, 45),

]