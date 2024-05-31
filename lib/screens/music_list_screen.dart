import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/device_song/device_songs_bloc.dart';
import '../bloc/favourite/favourite_songs_bloc.dart';
import 'music_player.dart';

class AllAudiosScreen extends StatelessWidget {
  final Function(String uri) onMusicChosen;

  const AllAudiosScreen({super.key, required this.onMusicChosen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeviceSongsBloc(OnAudioQuery())..add(FetchDeviceSongs()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          "All Songs",
          style: TextStyle(color: Colors.white),
        ),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),),
        ),
        body: BlocBuilder<DeviceSongsBloc, DeviceSongsState>(
          builder: (context, state) {
            if (state is DeviceSongsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DeviceSongsLoaded) {
              return ListView.builder(
                itemCount: state.songs.length,
                itemBuilder: (context, index) {
                  final song = state.songs[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListTile(
                      // leading: ,
                      title: Text(song.title),
                      subtitle: Text(song.artist ?? "Unknown Artist"),
                      onTap: () {
                        onMusicChosen(song.uri!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(song: song),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          BlocProvider.of<FavouriteSongsBloc>(context)
                              .add(AddFavouriteSong(song));
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Failed to load songs"));
            }
          },
        ),
      ),
    );
  }
}
