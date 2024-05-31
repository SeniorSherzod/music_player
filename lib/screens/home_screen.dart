import 'package:flutter/material.dart';
import 'permission_services.dart';
import 'music_favourite.dart';
import 'music_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Audio Player",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final hasPermission =
                await PermissionService.requestStoragePermission();
                if (hasPermission) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllAudiosScreen(
                        onMusicChosen: (uri) {},
                      ),
                    ),
                  );
                }
              },
              child: const Text("All Songs"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteSongsScreen(),
                  ),
                );
              },
              child: const Text("Favourite Songs"),
            ),
          ],
        ),
      ),
    );
  }
}
