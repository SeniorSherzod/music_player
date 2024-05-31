part of 'play_song_bloc.dart';

abstract class PlaySongState extends Equatable {
  const PlaySongState();

  @override
  List<Object> get props => [];
}

class PlaySongInitial extends PlaySongState {}

class SongPlaying extends PlaySongState {
  final SongModel song;
  final double volume;
  final bool isShuffling;
  final bool isRepeating;

  const SongPlaying(this.song,
      {required this.volume,
      required this.isShuffling,
      required this.isRepeating});

  @override
  List<Object> get props => [song, volume, isShuffling, isRepeating];
}

class SongPaused extends PlaySongState {
  final SongModel song;
  final double volume;

  const SongPaused(this.song, {required this.volume});

  @override
  List<Object> get props => [song, volume];
}

class SongStopped extends PlaySongState {}

class SongError extends PlaySongState {
  final String message;

  const SongError(this.message);

  @override
  List<Object> get props => [message];
}
