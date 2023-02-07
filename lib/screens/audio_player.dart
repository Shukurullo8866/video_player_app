import 'package:audio_player_app/model/music_model.dart';
import 'package:audio_player_app/screens/widget/value_changer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradients/gradients.dart';

import '../bloc/music_bloc.dart';
import '../bloc/music_bloc_event.dart';
import '../bloc/music_bloc_state.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen(MusicModel music, {Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer player = AudioPlayer();

  int currentValue = 0;
  bool isPlaying = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        int currentMusic = context.read<MusicPlayerBloc>().state.currentMusic!;
        return Scaffold(
          backgroundColor: Colors.purpleAccent,
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Audio Screen"),
            centerTitle: true,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradientPainter(
                colors: <Color>[
                  Colors.purpleAccent,
                  Colors.deepPurpleAccent,

                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(state.musics[currentMusic].image),
                            fit: BoxFit.fitHeight)),
                  ),
                  const SizedBox(height: 42),
                  // Text(
                  //   state.musics[currentMusic].name,
                  //   style: const TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 20),
                  // ),
                  const SizedBox(height: 8),
                  // Text(
                  //   state.musics[currentMusic].author,
                  //   style: const TextStyle(
                  //       color: Colors.grey,
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 20),
                  // ),
                  const SizedBox(
                    height: 32,
                  ),
                  Slider(
                    inactiveColor: Colors.grey,
                    activeColor: Colors.white,
                    max: context
                        .read<MusicPlayerBloc>()
                        .state
                        .maxDuration!
                        .inSeconds
                        .toDouble(),
                    value: context
                        .read<MusicPlayerBloc>()
                        .state
                        .currentSecond!
                        .inSeconds
                        .toDouble(),
                    onChangeStart: (value) {
                      context
                          .read<MusicPlayerBloc>()
                          .add(ChangeCurrentSecondEvent(second: value.toInt()));
                    },
                    onChangeEnd: (value) {
                      context
                          .read<MusicPlayerBloc>()
                          .add(ChangeCurrentSecondEvent(second: value.toInt()));
                    },
                    onChanged: (value) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${state.currentSecond!.inMinutes}:${state.currentSecond!.inSeconds % 60}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${state.maxDuration!.inMinutes}:${state.maxDuration!.inSeconds % 60}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.shuffle,
                      //       color: Colors.white,
                      //     )),
                      IconButton(
                          onPressed: () {
                            context
                                .read<MusicPlayerBloc>()
                                .state
                                .currentSecond = const Duration(seconds: 0);
                            context.read<MusicPlayerBloc>().add(SkipMusicEvent(
                                index:
                                    (currentMusic - 1) % state.musics.length));
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40,
                            color: Colors.white,
                          )),
                      IconButton(
                        onPressed: () {
                          if (state.musics[currentMusic].isPaused) {
                            context.read<MusicPlayerBloc>().add(
                                ResumeCurrentMusicEvent(index: currentMusic));
                          } else if (state.musics[currentMusic].isPlaying) {
                            context.read<MusicPlayerBloc>().add(
                                PauseCurrentMusicEvent(index: currentMusic));
                          } else {
                            context.read<MusicPlayerBloc>().add(
                                PlayCurrentMusicEvent(index: currentMusic));
                          }
                        },
                        icon: Icon(
                          state.musics[currentMusic].isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            context
                                .read<MusicPlayerBloc>()
                                .state
                                .currentSecond = const Duration(seconds: 0);
                            context.read<MusicPlayerBloc>().add(SkipMusicEvent(
                                index:
                                    (currentMusic + 1) % state.musics.length));
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40,
                            color: Colors.white,
                          )),
                      // IconButton(
                      //   onPressed: () {},
                      // icon: const Icon(
                      // Icons.repeat,
                      //color: Colors.white,
                      //)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
