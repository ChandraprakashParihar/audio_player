import 'package:audio_player/core/constants.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/state.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/state.dart';
import 'package:audio_player/features/audio_player/presentation/view/widgets/audio_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main screen that displays the audio player UI.
class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Initiates the audio download when the screen is loaded.
    context.read<DownloadAudioBloc>().add(StartAudioDownload(url: audioUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: BlocConsumer<DownloadAudioBloc, DownloadAudioState>(
        listener: (context, state) {
          if (state is DownloadAudioSuccess) {
            // Initialize the player when the audio download is successful.
            context.read<PlayerBloc>().add(
              InitializePlayer(path: state.filePath),
            );
          } else if (state is DownloadAudioFailure) {
            // Show an error message if the audio download fails.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to download audio: ${state.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DownloadAudioSuccess) {
            return BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, playerState) {
                if (playerState is PlayerReady ||
                    playerState is PlayerPlaying ||
                    playerState is PlayerPaused ||
                    playerState is PlayerStopped) {
                  return const AudioPlayerView();
                }
                return const Center(
                  child: Text(
                    'Waiting for audio...',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
