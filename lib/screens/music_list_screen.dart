import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_bloc.dart';

class MusicListScreen extends StatelessWidget {
  const MusicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MusicLoaded) {
            return ListView.builder(
              itemCount: state.musicFiles.length,
              itemBuilder: (context, index) {
                final music = state.musicFiles[index];
                return ListTile(
                  title: Text(music.title),
                  subtitle: Text(music.artist),
                  trailing: IconButton(
                    icon: Icon(
                      state.favorites.contains(music) ? Icons.favorite : Icons.favorite_border,
                      color: state.favorites.contains(music) ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (state.favorites.contains(music)) {
                        context.read<MusicBloc>().add(RemoveFromFavorites(music));
                      } else {
                        context.read<MusicBloc>().add(AddToFavorites(music));
                      }
                    },
                  ),
                  onTap: () {
                    context.read<MusicBloc>().add(PlayMusic(music));
                    Navigator.pushNamed(context, '/player');
                  },
                );
              },
            );
          } else if (state is MusicError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No music loaded'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MusicBloc>().add(LoadMusicFiles());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
