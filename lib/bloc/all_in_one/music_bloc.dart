// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../data/music_models.dart';
//
// part 'music_event.dart';
// part '../music_state.dart';
//
// class MusicBloc extends Bloc<MusicEvent, MusicState> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final List<Music> _favorites = [];
//
//   MusicBloc() : super(MusicInitial()) {
//     on<LoadMusicFiles>(_onLoadMusicFiles);
//     on<PlayMusic>(_onPlayMusic);
//     on<PauseMusic>(_onPauseMusic);
//     on<ResumeMusic>(_onResumeMusic);
//     on<SeekMusic>(_onSeekMusic);
//     on<AddToFavorites>(_onAddToFavorites);
//     on<RemoveFromFavorites>(_onRemoveFromFavorites);
//   }
//
//   void _onLoadMusicFiles(LoadMusicFiles event, Emitter<MusicState> emit) async {
//     emit(MusicLoading());
//
//     try {
//       List<Music> musicFiles = await _fetchMusicFilesFromStorage();
//       emit(MusicLoaded(musicFiles, favorites: _favorites));
//     } catch (e) {
//       emit(const MusicError('Error loading music files'));
//     }
//   }
//
//   Future<List<Music>> _fetchMusicFilesFromStorage() async {
//     List<Music> musicFiles = [];
//
//     try {
//       List<FileSystemEntity> files = await _listAllMP3Files();
//       for (var file in files) {
//         musicFiles.add(
//           Music(
//             filePath: file.path,
//             title: file.path.split('/').last,
//             artist: 'Unknown',
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error fetching music files: $e');
//     }
//
//     return musicFiles;
//   }
//
//   Future<List<FileSystemEntity>> _listAllMP3Files() async {
//     List<FileSystemEntity> mp3Files = [];
//     await _listFilesRecursive(Directory('/storage/emulated/0'), mp3Files);
//     return mp3Files;
//   }
//
//   Future<void> _listFilesRecursive(Directory dir, List<FileSystemEntity> mp3Files) async {
//     try {
//       List<FileSystemEntity> entities = dir.listSync();
//       for (var entity in entities) {
//         if (entity is File && entity.path.toLowerCase().endsWith('.mp3')) {
//           mp3Files.add(entity);
//         } else if (entity is Directory) {
//           if (!_isRestrictedDirectory(entity)) {
//             await _listFilesRecursive(entity, mp3Files);
//           } else {
//             debugPrint('Permission denied for directory: ${entity.path}');
//           }
//         }
//       }
//     } catch (e) {
//       debugPrint('Error listing files: $e');
//     }
//   }
//
//   bool _isRestrictedDirectory(Directory directory) {
//     final String path = directory.path;
//     return path.contains('/Android/data/') || path.contains('/Android/obb/');
//   }
//
//
//   // Remaining methods remain unchanged
//
//   // Example method to play music
//   void _onPlayMusic(PlayMusic event, Emitter<MusicState> emit) async {
//     await _audioPlayer.play(event.music.filePath as Source );
//     emit(MusicPlaying(event.music));
//   }
//
//   // Example method to pause music
//   void _onPauseMusic(PauseMusic event, Emitter<MusicState> emit) async {
//     await _audioPlayer.pause();
//     if (state is MusicPlaying) {
//       emit(MusicPaused((state as MusicPlaying).music));
//     }
//   }
//
//   // Example method to resume music
//   void _onResumeMusic(ResumeMusic event, Emitter<MusicState> emit) async {
//     await _audioPlayer.resume();
//     if (state is MusicPaused) {
//       emit(MusicPlaying((state as MusicPaused).music));
//     }
//   }
//
//   // Example method to seek music
//   void _onSeekMusic(SeekMusic event, Emitter<MusicState> emit) async {
//     await _audioPlayer.seek(event.position);
//     emit(MusicSeeked());
//   }
//
//   // Example method to add music to favorites
//   void _onAddToFavorites(AddToFavorites event, Emitter<MusicState> emit) {
//     _favorites.add(event.music);
//     emit(FavoriteMusicLoaded(List.from(_favorites)));
//   }
//
//   // Example method to remove music from favorites
//   void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<MusicState> emit) {
//     _favorites.remove(event.music);
//     emit(FavoriteMusicLoaded(List.from(_favorites)));
//   }
// }
