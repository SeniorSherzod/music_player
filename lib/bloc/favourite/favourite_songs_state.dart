part of 'favourite_songs_bloc.dart';

abstract class FavouriteSongsState extends Equatable {
  const FavouriteSongsState();

  @override
  List<Object> get props => [];
}

class FavouriteSongsInitial extends FavouriteSongsState {}

class FavouriteSongsUpdated extends FavouriteSongsState {
  final List<SongModel> songs;

  const FavouriteSongsUpdated(this.songs);

  @override
  List<Object> get props => [songs];
}
