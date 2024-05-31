part of 'device_songs_bloc.dart';

abstract class DeviceSongsEvent extends Equatable {
  const DeviceSongsEvent();

  @override
  List<Object> get props => [];
}

class FetchDeviceSongs extends DeviceSongsEvent {}



