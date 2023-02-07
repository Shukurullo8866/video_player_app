import 'package:audio_player_app/screens/audio_player.dart';
import 'package:audio_player_app/screens/mp_list/mp_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/music_bloc.dart';

void main() {
  runApp(
      MultiBlocProvider(providers: [

        BlocProvider(
          create: (context) => MusicPlayerBloc(),
        ),
      ], child: MyApp())

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  PlayListPage(),
    );
  }
}

