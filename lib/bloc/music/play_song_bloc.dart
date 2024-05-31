import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
part 'play_song_event.dart';
part 'play_song_state.dart';

class PlaySongBloc extends Bloc<PlaySongEvent, PlaySongState> {
  final AudioPlayer audioPlayer;
  bool isShuffling = false;
  bool isRepeating = false;

  PlaySongBloc(this.audioPlayer) : super(PlaySongInitial()) {
    on<PlaySong>((event, emit) async {
      try {
        if (event.song.uri == null) {
          emit(const SongError("Invalid song URI"));
          return;
        }
        debugPrint("Loading song URI: ${event.song.uri}");
        await audioPlayer.setUrl(event.song.uri!);
        await audioPlayer.play();
        emit(SongPlaying(event.song, volume: audioPlayer.volume, isShuffling: isShuffling, isRepeating: isRepeating));
      } catch (e) {
        debugPrint("Error playing song: ${e.toString()}");
        emit(SongError("Unable to play the song: ${event.song.title}"));
      }
    });

    on<PauseSong>((event, emit) async {
      try {
        await audioPlayer.pause();
        emit(SongPaused(event.song, volume: audioPlayer.volume));
      } catch (e) {
        debugPrint("Error pausing song: ${e.toString()}");
        emit(SongError("Unable to pause the song: ${event.song.title}"));
      }
    });

    on<StopSong>((event, emit) async {
      try {
        await audioPlayer.stop();
        emit(SongStopped());
      } catch (e) {
        debugPrint("Error stopping song: ${e.toString()}");
        emit(const SongError("Unable to stop the song"));
      }
    });

    on<SeekForward>((event, emit) async {
      try {
        final currentPosition = audioPlayer.position;
        final newPosition = currentPosition + Duration(seconds: event.seconds);
        await audioPlayer.seek(newPosition);
      } catch (e) {
        debugPrint("Error seeking forward: ${e.toString()}");
        emit(const SongError("Unable to seek forward"));
      }
    });

    on<SeekBackward>((event, emit) async {
      try {
        final currentPosition = audioPlayer.position;
        final newPosition = currentPosition - Duration(seconds: event.seconds);
        await audioPlayer.seek(newPosition);
      } catch (e) {
        debugPrint("Error seeking backward: ${e.toString()}");
        emit(const SongError("Unable to seek backward"));
      }
    });

    on<ChangeVolume>((event, emit) async {
      try {
        await audioPlayer.setVolume(event.volume);
        if (state is SongPlaying) {
          emit(SongPlaying((state as SongPlaying).song, volume: event.volume, isShuffling: isShuffling, isRepeating: isRepeating));
        } else if (state is SongPaused) {
          emit(SongPaused((state as SongPaused).song, volume: event.volume));
        }
      } catch (e) {
        debugPrint("Error changing volume: ${e.toString()}");
        emit(const SongError("Unable to change volume"));
      }
    });

    on<ToggleShuffle>((event, emit) {
      isShuffling = !isShuffling;
      audioPlayer.setShuffleModeEnabled(isShuffling);
      if (state is SongPlaying) {
        emit(SongPlaying((state as SongPlaying).song, volume: (state as SongPlaying).volume, isShuffling: isShuffling, isRepeating: isRepeating));
      }
    });

    on<ToggleRepeat>((event, emit) {
      isRepeating = !isRepeating;
      audioPlayer.setLoopMode(isRepeating ? LoopMode.one : LoopMode.off);
      if (state is SongPlaying) {
        emit(SongPlaying((state as SongPlaying).song, volume: (state as SongPlaying).volume, isShuffling: isShuffling, isRepeating: isRepeating));
      }
    });
  }
}
