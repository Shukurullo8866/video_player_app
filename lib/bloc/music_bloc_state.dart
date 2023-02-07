import 'package:equatable/equatable.dart';
import '../model/music_model.dart';

class MusicPlayerState extends Equatable {
  MusicStatus? status;
  Duration? currentSecond;
  Duration? maxDuration;
  int? currentMusic;
  List<MusicModel> musics = [
    MusicModel(
        image:"https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
        name: "Shohruhxon",
        path: "shohruh2.mp3",
        author: "vvv"),
    MusicModel(
        image:
        "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
        name: "shohruh",
        path: "shohruh3.mp3",
        author: "4655"),
    MusicModel(
        image:
        "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
        name: "shohruh",
        path: "shohruh3.mp3",
        author: "1236"),

  ];

  MusicPlayerState(
      {this.status, this.currentSecond, this.maxDuration, this.currentMusic,required this.musics});

  copyWith(
      {Duration? maxDuration,
        Duration? currentSecond,
        MusicStatus? status,
        int? currentMusic,
        List<MusicModel>? musics}) {
    return MusicPlayerState(
        musics: musics??this.musics,
        currentSecond: currentSecond ?? this.currentSecond,
        status: status ?? this.status,
        maxDuration: maxDuration ?? this.maxDuration,
        currentMusic: currentMusic ?? this.currentMusic);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, currentSecond, musics, maxDuration];
}

enum MusicStatus {
  STOPPED,
  PLAYING,
  PAUSED,
}