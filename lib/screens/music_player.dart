import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/screens/widgets/player_widgets.dart';
import '../bloc/music_bloc.dart';

class PlayerScreen extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicPlaying || state is MusicPaused) {
            final music = state is MusicPlaying ? state.music : (state as MusicPaused).music;
            return PlayerTask(player: _audioPlayer, music: music);
          } else {
            return const Center(child: Text('No music playing'));
          }
        },
      ),
    );
  }
}


