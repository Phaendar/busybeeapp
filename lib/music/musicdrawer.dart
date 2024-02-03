import 'package:flutter/material.dart';
import 'songs_data.dart';

import 'package:audioplayers/audioplayers.dart';

AudioPlayer? activePlayer; // Store the currently playing player

class MusicDrawer extends StatelessWidget {
  final Function(int) onSongSelected; // Callback function

  const MusicDrawer({super.key, required this.onSongSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.yellow,
      shadowColor: Colors.yellow.shade700,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Songs',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: songList.length,
            itemBuilder: (BuildContext context, int index) {
              final song = songList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListTile(
                  leading: Image.asset(song['coverImage']!),
                  title: Text(song['name']!),
                  subtitle: Text(song['artist']!),
                  onTap: () {
                    if (activePlayer != null) {
                      activePlayer!.stop();
                      activePlayer!.dispose();
                    }
                    onSongSelected(
                        index); // Call the callback with the selected song's index
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
