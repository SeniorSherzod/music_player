import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/screens/home_screen.dart';

import '../bloc/favourite/favourite_songs_bloc.dart';
import 'music_player.dart';

class FavouriteSongsScreen extends StatelessWidget {
  const FavouriteSongsScreen({super.key});

  get song => null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteSongsBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Favourite Songs",style: TextStyle(color: Colors.white),
        ),
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
          },icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),),
        ),
        body: BlocBuilder<FavouriteSongsBloc, FavouriteSongsState>(
          builder: (context, state) {
            if (state is FavouriteSongsUpdated) {
              return ListView.builder(
                itemCount: state.songs.length,
                itemBuilder: (context, index) {
                  final song = state.songs[index];
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist ?? "Unknown Artist",style: const TextStyle(color: Colors.white),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(song: song),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite,color: Colors.white,),
                      onPressed: () {
                        BlocProvider.of<FavouriteSongsBloc>(context).add(RemoveFavouriteSong(song));
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No favourite songs yet"));
            }
          },
        ),
      ),
    );
  }
}
