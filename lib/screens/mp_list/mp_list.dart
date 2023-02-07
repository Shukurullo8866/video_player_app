import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/music_bloc.dart';
import '../audio_player.dart';

class PlayListPage extends StatelessWidget {
  PlayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Play List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AudioScreen(context.read<MusicPlayerBloc>().state.musics[index]),
                  ),
                );

              },
              child: Container(
                child: Column(
                  children: [
                    Text(
                      context.read<MusicPlayerBloc>().state.musics[index].name,style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: context.read<MusicPlayerBloc>().state.musics.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
          ),
        ),
      ),
    );
  }
}
