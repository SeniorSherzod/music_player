part of 'device_songs_bloc.dart';

abstract class DeviceSongsState extends Equatable {
  const DeviceSongsState();

  @override
  List<Object> get props => [];
}

class DeviceSongsInitial extends DeviceSongsState {}

class DeviceSongsLoading extends DeviceSongsState {}

class DeviceSongsLoaded extends DeviceSongsState {
  final List<SongModel> songs;

  const DeviceSongsLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class DeviceSongsError extends DeviceSongsState {
  final String message;

  const DeviceSongsError(this.message);

  @override
  List<Object> get props => [message];
}
