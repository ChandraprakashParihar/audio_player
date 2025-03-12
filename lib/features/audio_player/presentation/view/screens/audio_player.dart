// import 'package:audio_player/core/constants.dart';
// import 'package:audio_player/core/extensions.dart';
// import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/bloc.dart';
// import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/event.dart';
// import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/state.dart';
// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AudioPlayer extends StatefulWidget {
//   const AudioPlayer({super.key});

//   @override
//   State<AudioPlayer> createState() => _AudioPlayerState();
// }

// class _AudioPlayerState extends State<AudioPlayer> {
//   late PlayerController playerController;
//   String? path;
//   bool isCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//     context.read<DownloadAudioBloc>().add(StartAudioDownload(url: audioUrl));
//   }

//   /// Initializes the player controller and sets up listeners
//   void _initializeController() {
//     playerController = PlayerController();

//     // Listen for playback completion and reset
//     playerController.onCompletion.listen((_) {
//       setState(() {
//         isCompleted = true;
//         playerController.seekTo(0); // Reset to start
//       });
//     });
//   }

//   /// Handles play and pause functionality
//   void _playAndPause() async {
//     if (path == null) return; // Ensure file is ready

//     if (isCompleted) {
//       // Restart if completed
//       await playerController.preparePlayer(path: path!);
//       await playerController.startPlayer();
//       setState(() => isCompleted = false);
//     } else if (playerController.playerState == PlayerState.playing) {
//       await playerController.pausePlayer();
//     } else {
//       await playerController.startPlayer();
//     }

//     setState(() {}); // Ensure UI updates
//   }

//   @override
//   void dispose() {
//     playerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.grey.shade900,
//       body: BlocConsumer<DownloadAudioBloc, DownloadAudioState>(
//         listener: (context, state) {
//           if (state is DownloadAudioSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Audio downloaded successfully at ${state.filePath}',
//                 ),
//               ),
//             );
//             path = state.filePath;
//             playerController.preparePlayer(path: path!);
//           } else if (state is DownloadAudioFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Failed to download audio: ${state.message}'),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is DownloadAudioSuccess) {
//             return Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         'https://images.pexels.com/photos/3274210/pexels-photo-3274210.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(height: MediaQuery.sizeOf(context).height * 0.6),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade900,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Instant Crush",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),

//                             Text(
//                               "feat. Julian Casablancas",
//                               style: TextStyle(
//                                 color: Colors.grey.shade400,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             40.sBH,
//                             AudioFileWaveforms(
//                               playerController: playerController,
//                               size: const Size(300, 50),
//                             ),
//                             IconButton(
//                               onPressed: _playAndPause,
//                               icon: Icon(
//                                 playerController.playerState ==
//                                         PlayerState.playing
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

import 'package:audio_player/core/constants.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/state.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/state.dart';
import 'package:audio_waveforms/audio_waveforms.dart' as audio_waveforms;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DownloadAudioBloc>().add(StartAudioDownload(url: audioUrl));
  }

  String _formatDuration(int milliseconds) {
    final int seconds = (milliseconds / 1000).floor();
    final int minutes = (seconds / 60).floor();
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      backgroundColor: Colors.black,
      body: BlocConsumer<DownloadAudioBloc, DownloadAudioState>(
        listener: (context, state) {
          if (state is DownloadAudioSuccess) {
            context.read<PlayerBloc>().add(
              InitializePlayer(path: state.filePath),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Audio downloaded successfully at ${state.filePath}',
                ),
              ),
            );
          } else if (state is DownloadAudioFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to download audio: ${state.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DownloadAudioInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, playerState) {
              if (playerState is PlayerReady ||
                  playerState is PlayerPlaying ||
                  playerState is PlayerPaused ||
                  playerState is PlayerStopped) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (playerState is PlayerReady ||
                        playerState is PlayerPlaying ||
                        playerState is PlayerPaused)
                      audio_waveforms.AudioFileWaveforms(
                        playerController: playerState.controller,
                        size: const Size(300, 50),
                      ),
                    const SizedBox(height: 20),
                    Text(
                      _formatDuration(playerState.position),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed:
                          () =>
                              context.read<PlayerBloc>().add(PlayPauseAudio()),
                      icon: Icon(
                        playerState is PlayerPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text(
                  'Waiting for audio...',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
