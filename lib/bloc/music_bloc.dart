
import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';

import '../model/music_model.dart';
import 'music_bloc_event.dart';
import 'music_bloc_state.dart';



class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerBloc() : super(MusicPlayerState(
      status: MusicStatus.STOPPED,
      currentMusic: 0,
      currentSecond:const Duration(seconds: 0),
      maxDuration: const Duration(seconds: 0),
      musics: [
        MusicModel(
            image:"https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
            name: "Shohruhxon",
            path: "assets/shohruh2.mp3",
            author: "vvv"),
        MusicModel(
            image:
            "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
            name: "shohruh",
            path: "assets/shohruh3.mp3",
            author: "4655"),
        MusicModel(
            image:
            "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/4f/42/91/4f4291ad-7aa2-8727-cf48-fb6c46181d53/cover.jpg/486x486bb.png",
            name: "shohruh",
            path: "assets/shohruh4.mp3",
            author: "1236"),

      ]
  )) {
    on<PlayCurrentMusicEvent>(playMusic);
    on<PauseCurrentMusicEvent>(pauseMusic);
    on<ResumeCurrentMusicEvent>(resumeMusic);
    on<ChangeCurrentSecondEvent>(seekMusic);
    on<SkipMusicEvent>(skipMusic);
    on<IndicatiorEvent>(indicator);
    on<InitMusicEvent>(initMusic);
  }

  final AudioPlayer player = AudioPlayer();


  initMusic(InitMusicEvent event, emit) async {
    await player.setSource(AssetSource(state.musics[event.index].path));
    Duration? maxDuration = await player.getDuration();
    emit(state.copyWith(currentMusic: event.index,maxDuration: maxDuration,currentSecond: const Duration(seconds: 0),musics: state.musics));
  }




  playMusic(PlayCurrentMusicEvent event, emit) async {
    await player.play(AssetSource(state.musics[event.index].path),position: state.currentSecond);
    player.onPositionChanged.listen((event) {
      add(IndicatiorEvent(currentSecond: event.inSeconds));
    });
    add(InitMusicEvent(index: event.index));
    emit(state.copyWith(status: MusicStatus.PLAYING,musics: state.musics..[event.index].isPlaying=true,currentMusic: event.index));
  }

  indicator(IndicatiorEvent event, emit){
    emit(state.copyWith(status: MusicStatus.PLAYING,currentSecond: Duration(seconds: event.currentSecond)));
  }

  pauseMusic(PauseCurrentMusicEvent event, emit) async {
    await player.pause();
    emit(state.copyWith(status: MusicStatus.PAUSED,musics: state.musics..[event.index].isPlaying=false..[event.index].isPaused=true));
  }

  resumeMusic(ResumeCurrentMusicEvent event, emit) async {
    await player.resume();
    player.onPositionChanged.listen((event) {
      add(IndicatiorEvent(currentSecond: event.inSeconds));
    });
    emit(state.copyWith(status: MusicStatus.PAUSED,musics: state.musics..[event.index].isPlaying=true..[event.index].isPaused=false));


  }
  seekMusic(ChangeCurrentSecondEvent event, emit) async {
    await player.seek(Duration(seconds: event.second));
    emit(state.copyWith(currentSecond: Duration(seconds: event.second)));
  }
  skipMusic(SkipMusicEvent event, emit) async {
    await player.stop();
    add(PlayCurrentMusicEvent(index: event.index));

  }
}