



import 'package:flutter/cupertino.dart';

@immutable
abstract class MusicPlayerEvent {}

class PlayCurrentMusicEvent extends MusicPlayerEvent{
  int index;
  PlayCurrentMusicEvent({required this.index});
}

class StopCurrentMusicEvent extends MusicPlayerEvent{}

class PauseCurrentMusicEvent extends MusicPlayerEvent{
  int index;
  PauseCurrentMusicEvent({required this.index});
}

class ResumeCurrentMusicEvent extends MusicPlayerEvent{
  int index;
  ResumeCurrentMusicEvent({required this.index});
}

// ignore: must_be_immutable
class ChangeCurrentSecondEvent extends MusicPlayerEvent{
  int second;
  ChangeCurrentSecondEvent({required this.second});
}



class SkipMusicEvent extends MusicPlayerEvent{
  int index;
  SkipMusicEvent({required this.index});
}

class IndicatiorEvent extends MusicPlayerEvent{
  int currentSecond;
  IndicatiorEvent({required this.currentSecond});
}

class InitMusicEvent extends MusicPlayerEvent{
  int index;

  InitMusicEvent({required this.index});

}
