part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object?> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<Music> musicFiles;
  final List<Music> favorites;

  const MusicLoaded(this.musicFiles, {this.favorites = const []});

  @override
  List<Object?> get props => [musicFiles, favorites];
}

class MusicPlaying extends MusicState {
  final Music music;

  const MusicPlaying(this.music);

  @override
  List<Object?> get props => [music];
}

class MusicPaused extends MusicState {
  final Music music;

  const MusicPaused(this.music);

  @override
  List<Object?> get props => [music];
}

class MusicStopped extends MusicState {}

class MusicSeeked extends MusicState {}

class MusicError extends MusicState {
  final String message;

  const MusicError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteMusicLoaded extends MusicState {
  final List<Music> favorites;

  const FavoriteMusicLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
