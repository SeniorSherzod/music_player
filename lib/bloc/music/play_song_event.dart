part of 'play_song_bloc.dart';

abstract class PlaySongEvent extends Equatable {
  const PlaySongEvent();

  @override
  List<Object> get props => [];
}

class PlaySong extends PlaySongEvent {
  final SongModel song;

  const PlaySong(this.song);

  @override
  List<Object> get props => [song];
}

class PauseSong extends PlaySongEvent {
  final SongModel song;

  const PauseSong(this.song);

  @override
  List<Object> get props => [song];
}

class StopSong extends PlaySongEvent {}

class SeekForward extends PlaySongEvent {
  final int seconds;

  const SeekForward(this.seconds);

  @override
  List<Object> get props => [seconds];
}

class SeekBackward extends PlaySongEvent {
  final int seconds;

  const SeekBackward(this.seconds);

  @override
  List<Object> get props => [seconds];
}

class ChangeVolume extends PlaySongEvent {
  final double volume;

  const ChangeVolume(this.volume);

  @override
  List<Object> get props => [volume];
}

class ToggleShuffle extends PlaySongEvent {}

class ToggleRepeat extends PlaySongEvent {}
