part of 'favourite_songs_bloc.dart';

abstract class FavouriteSongsEvent extends Equatable {
  const FavouriteSongsEvent();

  @override
  List<Object> get props => [];
}

class AddFavouriteSong extends FavouriteSongsEvent {
  final SongModel song;

  const AddFavouriteSong(this.song);

  @override
  List<Object> get props => [song];
}

class RemoveFavouriteSong extends FavouriteSongsEvent {
  final SongModel song;

  const RemoveFavouriteSong(this.song);

  @override
  List<Object> get props => [song];
}
