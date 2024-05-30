import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is FavoriteMusicLoaded) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final music = state.favorites[index];
                return ListTile(
                  title: Text(music.title),
                  subtitle: Text(music.artist),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      context.read<MusicBloc>().add(RemoveFromFavorites(music));
                    },
                  ),
                  onTap: () {
                    context.read<MusicBloc>().add(PlayMusic(music));
                    Navigator.pushNamed(context, '/player');
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No favorites added'));
          }
        },
      ),
    );
  }
}
