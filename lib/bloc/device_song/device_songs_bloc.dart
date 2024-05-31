import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';
part 'device_songs_event.dart';
part 'device_songs_state.dart';

class DeviceSongsBloc extends Bloc<DeviceSongsEvent, DeviceSongsState> {
  final OnAudioQuery audioQuery;

  DeviceSongsBloc(this.audioQuery) : super(DeviceSongsInitial()) {
    on<FetchDeviceSongs>((event, emit) async {
      emit(DeviceSongsLoading());
      try {
        final songs = await audioQuery.querySongs();
        emit(DeviceSongsLoaded(songs));
      } catch (e) {
        emit(const DeviceSongsError("Failed to fetch songs"));
      }
    });
  }
}