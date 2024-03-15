import 'package:audioplayers/audioplayers.dart';
import 'package:busybeelearning/music/musicdrawer.dart';
import 'package:busybeelearning/shared/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'songs_data.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class MusicPlayerScreen extends StatefulWidget {
  final int selectedIndex;

  const MusicPlayerScreen({super.key, required this.selectedIndex});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

enum RepeatMode {
  noRepeat,
  repeatAll,
  repeatOne,
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final player = AudioPlayer(playerId: 'mainPlayer');

  PlayerState playerState = PlayerState.stopped;
  int currentIndex = 0;

  Duration _currentPosition = Duration.zero; // Current playback position
  Duration _songDuration = Duration.zero; // Total song duration

  RepeatMode repeatMode = RepeatMode.noRepeat;

  bool shuffleMode = false;

  late AnimationController _animationController;

  Future<void> playSong(int index) async {
    await player.stop();
    if (shuffleMode) {
      songList.shuffle(); // Shuffle the playlist
    }
    await player.setSourceAsset(songList[index]['audio']!);
    await player.resume();
    setState(() {
      currentIndex = index;
      playerState = PlayerState.playing;
    });
    // Trigger the sliding animation
    _animationController.forward(from: 0);
  }

  Future<void> nextSong() async {
    int nextIndex;
    switch (repeatMode) {
      case RepeatMode.noRepeat:
        nextIndex = (currentIndex + 1) % songList.length;
        break;
      case RepeatMode.repeatAll:
        nextIndex = (currentIndex + 1) % songList.length;
        break;
      case RepeatMode.repeatOne:
        nextIndex = currentIndex;
        break;
    }
    await playSong(nextIndex);
  }

  Future<void> previousSong() async {
    int previousIndex;
    switch (repeatMode) {
      case RepeatMode.noRepeat:
        previousIndex = (currentIndex - 1 + songList.length) % songList.length;
        break;
      case RepeatMode.repeatAll:
        previousIndex = (currentIndex - 1 + songList.length) % songList.length;
        break;
      case RepeatMode.repeatOne:
        previousIndex = currentIndex;
        break;
    }
    await playSong(previousIndex);
  }

  @override
  void initState() {
    super.initState();

    // Extract the selected index from the route arguments
    final selectedIndex = widget.selectedIndex;

    // Play the selected song using the retrieved index
    playSong(selectedIndex);

    // Listen to audio player events to update position and duration
    player.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPosition = position;
      });
    });

    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        _songDuration = duration;
      });
    });

    // Listen to player completion event
    player.onPlayerComplete.listen((event) {
      _handleSongCompletion();
    });

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _animationController.value = 1.0;
  }

  Future<void> getAudio(String assetPath) async {
    await player.setSourceAsset(assetPath);
  }

  void togglePlayPause() {
    if (playerState == PlayerState.playing) {
      player.pause();
      setState(() {
        playerState = PlayerState.paused;
      });
    } else if (playerState == PlayerState.paused ||
        playerState == PlayerState.stopped) {
      player.resume();
      setState(() {
        playerState = PlayerState.playing;
      });
    }
  }

  void _handleSongCompletion() {
    if (currentIndex < songList.length - 1) {
      nextSong();
    } else {
      // If shuffle mode is on, shuffle the playlist and play the first song
      if (shuffleMode) {
        songList.shuffle();
      }
      playSong(0); // Play the first song
    }
  }

  void playSelectedSong(int index) async {
    await player.stop();
    if (shuffleMode) {
      songList.shuffle(); // Shuffle the playlist
    }
    await player.setSourceAsset(songList[index]['audio']!);
    await player.resume();
    setState(() {
      currentIndex = index;
      playerState = PlayerState.playing;
    });
    _animationController.forward(from: 0); // Trigger the sliding animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer:
          MusicDrawer(onSongSelected: playSelectedSong), // Pass the callback
      backgroundColor: customcolor.AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              //back button and menu button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      player.stop();
                    },
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: NeuBox(
                          child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  const Text('STUDY MUSIC',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  FilledButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () => _key.currentState!.openDrawer(),
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: NeuBox(
                          child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              //song name and artist name and cover image
              SizedBox(
                height: 440,
                width: 425,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0), // Slide from the right
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut, // Adjust the curve as needed
                  )),
                  child: NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                                songList[currentIndex]['coverImage']!)),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(songList[currentIndex]['name']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  const SizedBox(height: 4),
                                  Text(songList[currentIndex]['artist']!,
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                              const FavoriteButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              //start time and end time, shuffle and repeat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_formatDuration(_currentPosition)),
                  IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        color: shuffleMode ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          shuffleMode = !shuffleMode;
                        });
                      }),
                  IconButton(
                    icon: Icon(
                      repeatMode == RepeatMode.repeatAll
                          ? Icons.repeat
                          : repeatMode == RepeatMode.repeatOne
                              ? Icons.repeat_one
                              : Icons.repeat, // Default icon for no repeat mode
                      color:
                          repeatMode != RepeatMode.noRepeat ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        repeatMode = RepeatMode.values[
                            (repeatMode.index + 1) % RepeatMode.values.length];
                      });
                    },
                  ),
                  Text(_formatDuration(_songDuration)),
                ],
              ),

              const SizedBox(height: 15),

              //slider
              NeuBox(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return GestureDetector(
                      behavior: HitTestBehavior
                          .translucent, // Make the entire container tappable
                      onTapDown: (tapDetails) {
                        if (_songDuration.inMilliseconds > 0) {
                          double tapPosition = tapDetails.localPosition.dx /
                              constraints.maxWidth;
                          Duration seekPosition = Duration(
                            milliseconds:
                                (_songDuration.inMilliseconds * tapPosition)
                                    .toInt(),
                          );
                          player.seek(seekPosition);
                        }
                      },
                      child: GestureDetector(
                        onHorizontalDragUpdate: (dragDetails) {
                          double newPosition = dragDetails.localPosition.dx /
                              constraints.maxWidth;
                          newPosition = newPosition.clamp(0.0, 1.0);
                          Duration seekPosition = Duration(
                            milliseconds:
                                (_songDuration.inMilliseconds * newPosition)
                                    .toInt(),
                          );
                          player.seek(seekPosition);
                        },
                        child: LinearPercentIndicator(
                          lineHeight: 10,
                          percent: _songDuration.inMilliseconds > 0
                              ? _currentPosition.inMilliseconds /
                                  _songDuration.inMilliseconds
                              : 0.0,
                          progressColor: Colors.red,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.elliptical(4, 4),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              //play, previous and next buttons
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                        child: NeuBox(
                            child: IconButton(
                                icon: const Icon(Icons.skip_previous, size: 32),
                                onPressed: () {
                                  previousSong();
                                }))),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: NeuBox(
                                child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed:
                                  togglePlayPause, // Toggle play/pause when button is pressed
                              child: Icon(
                                playerState == PlayerState.playing
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 32,
                                color: Colors.black,
                              ),
                            )))),
                    Expanded(
                        child: NeuBox(
                            child: IconButton(
                                icon: const Icon(Icons.skip_next, size: 32),
                                onPressed: () {
                                  nextSong();
                                }))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
        color: _isFavorited ? Colors.red : null,
      ),
      iconSize: 32,
      onPressed: _toggleFavorite,
    );
  }
}
