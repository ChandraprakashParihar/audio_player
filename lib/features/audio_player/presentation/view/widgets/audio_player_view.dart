import 'package:audio_player/features/audio_player/presentation/view/widgets/album_art.dart';
import 'package:audio_player/features/audio_player/presentation/view/widgets/player_controls.dart';
import 'package:flutter/material.dart';

/// Displays the main UI components of the audio player.
class AudioPlayerView extends StatelessWidget {
  const AudioPlayerView({super.key});

  /// Formats the duration from milliseconds to a `mm:ss` format.
  String _formatDuration(int milliseconds) {
    final int seconds = (milliseconds / 1000).floor();
    final int minutes = (seconds / 60).floor();
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AlbumArt(),
        Align(
          alignment: Alignment.bottomCenter,
          child: PlayerControls(formatDuration: _formatDuration),
        ),
      ],
    );
  }
}
