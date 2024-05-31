import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'favourite_songs_event.dart';
part 'favourite_songs_state.dart';

class FavouriteSongsBloc extends Bloc<FavouriteSongsEvent, FavouriteSongsState> {
  final List<SongModel> favouriteSongs = [];

  FavouriteSongsBloc() : super(FavouriteSongsInitial()) {
    on<AddFavouriteSong>((event, emit) {
      favouriteSongs.add(event.song);
      emit(FavouriteSongsUpdated(List.from(favouriteSongs)));
    });

    on<RemoveFavouriteSong>((event, emit) {
      favouriteSongs.remove(event.song);
      emit(FavouriteSongsUpdated(List.from(favouriteSongs)));
    });
  }
}
