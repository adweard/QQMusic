import { musicInfoModel } from './musicInfoModel'

export class musicModel {
  Info: musicInfoModel

  constructor(Info: musicInfoModel) {
    this.Info = Info
  }
}

export const RammsteinList: musicModel[] = [
  new musicModel(new musicInfoModel('Ich will', 'app.media.p1', 'Rammstein', false, '沉浸声', '')),
  new musicModel(new musicInfoModel('Eifersucht', 'app.media.p2', 'Rammstein', false, '沉浸声', '')),
  new musicModel(new musicInfoModel('Links 2 3 4', 'app.media.p3', 'Rammstein', false, '沉浸声', '')),
  new musicModel(new musicInfoModel('Strib Nicht Vor Mir (Don\'t Die Before I Do)', 'app.media.p1', 'Rammstein', false,
    'VIP', '')),
  new musicModel(new musicInfoModel('Du Hast', 'app.media.p2', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Amerika', 'app.media.p3', 'Rammstein', false, '沉浸声', '')),
  new musicModel(new musicInfoModel('Sehnsucht', 'app.media.p1', 'Rammstein', false, '杜比', '')),
  new musicModel(new musicInfoModel('Engel', 'app.media.p2', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Mutter', 'app.media.p3', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Asche zu Asche', 'app.media.p1', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Spieluhr', 'app.media.p2', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Rosenrot', 'app.media.p3', 'Rammstein/Northern Life', false, 'SQ', '')),
  new musicModel(new musicInfoModel('Buck dich', 'app.media.p1', 'Rammstein', false, '杜比', '')),
  new musicModel(new musicInfoModel('Spiel mich', 'app.media.p2', 'Rammstein', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Fade To Black', 'app.media.p3', 'Metallica', false, '超清母带', '')),
  new musicModel(new musicInfoModel('Enter Sandman', 'app.media.p1', 'Metallica', false, '超清母带', '')),
  new musicModel(new musicInfoModel('The Unforgiven', 'app.media.p2', 'Metallica', false, 'VIP', '')),
  new musicModel(new musicInfoModel('Master of Puppets', 'app.media.p3', 'Metallica', false, 'VIP', '')),
  new musicModel(new musicInfoModel('The Unforgiven II', 'app.media.p1', 'Metallica', false, 'VIP', '')),
  new musicModel(new musicInfoModel('One', 'app.media.p2', 'Metallica', false, 'VIP', '')),

]