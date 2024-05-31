import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'bloc/device_song/device_songs_bloc.dart';
import 'bloc/favourite/favourite_songs_bloc.dart';
import 'bloc/music/play_song_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DeviceSongsBloc(OnAudioQuery())),
        BlocProvider(create: (_) => FavouriteSongsBloc()),
        BlocProvider(create: (_) => PlaySongBloc(AudioPlayer())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
