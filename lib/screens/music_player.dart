import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as justaudioplayers;
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/music/play_song_bloc.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaySongBloc(justaudioplayers.AudioPlayer()),
      child: Scaffold(
        appBar: AppBar(title: Text(song.title)),
        body: BlocBuilder<PlaySongBloc, PlaySongState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAlbumArtwork(context),
                _buildSongDetails(song),
                _buildPlaybackControls(context, song, state),
                _buildVolumeSlider(context, state),
                _buildPlaybackOptions(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlbumArtwork(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: OnAudioQuery().queryArtwork(song.id, ArtworkType.AUDIO),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          return Image.memory(snapshot.data!, fit: BoxFit.cover, height: 200, width: 200);
        } else {
          return const Icon(Icons.music_note, size: 200);
        }
      },
    );
  }

  Widget _buildSongDetails(SongModel song) {
    return Column(
      children: [
        Text(song.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(song.artist ?? "Unknown Artist"),
      ],
    );
  }

  Widget _buildPlaybackControls(BuildContext context, SongModel song, PlaySongState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () {
            context.read<PlaySongBloc>().add(SeekForward(song as int));
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay_10),
          onPressed: () {
            context.read<PlaySongBloc>().add(const SeekBackward(15));
          },
        ),
        IconButton(
          icon: Icon(state is SongPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (state is SongPlaying) {
              context.read<PlaySongBloc>().add(PauseSong(song));
            } else {
              context.read<PlaySongBloc>().add(PlaySong(song));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          onPressed: () {
            context.read<PlaySongBloc>().add(const SeekForward(15));
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () {
            context.read<PlaySongBloc>().add(SeekForward(song as int));
          },
        ),
      ],
    );
  }

  Widget _buildVolumeSlider(BuildContext context, PlaySongState state) {
    return Slider(
      value: state is SongPlaying ? state.volume : 0.5,
      min: 0,
      max: 1,
      onChanged: (value) {
        context.read<PlaySongBloc>().add(ChangeVolume(value));
      },
    );
  }

  Widget _buildPlaybackOptions(BuildContext context, PlaySongState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(state is SongPlaying && state.isShuffling ? Icons.shuffle_on : Icons.shuffle),
          onPressed: () {
            context.read<PlaySongBloc>().add(ToggleShuffle());
          },
        ),
        IconButton(
          icon: Icon(state is SongPlaying && state.isRepeating ? Icons.repeat_on : Icons.repeat),
          onPressed: () {
            context.read<PlaySongBloc>().add(ToggleRepeat());
          },
        ),
      ],
    );
  }
}
