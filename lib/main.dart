import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/screens/container.dart';
import 'package:music_player/screens/music_favourite.dart';
import 'package:music_player/screens/music_player.dart';
import 'bloc/music_bloc.dart';
import 'screens/music_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicBloc()..add(LoadMusicFiles()),
      child: MaterialApp(
        title: 'Music Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContainerScreen(),
        // initialRoute:,
        // routes: {
        //   '/': (context) => const MusicListScreen(),
        //   '/player': (context) => PlayerScreen(),
        //   '/favorites': (context) => const FavoriteScreen(),
        // },
      ),
    );
  }
}
