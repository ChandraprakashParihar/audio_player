import 'package:audio_player/core/extensions.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/state.dart';
import 'package:audio_waveforms/audio_waveforms.dart' as audio_waveforms;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Controls for playing and pausing audio, showing progress, and displaying song details.
class PlayerControls extends StatelessWidget {
  final String Function(int) formatDuration;
  const PlayerControls({super.key, required this.formatDuration});

  @override
  Widget build(BuildContext context) {
    final playerState = context.watch<PlayerBloc>().state;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          8.sBH,
          Text(
            "Instant Crush",
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "feat. Julian Casablancas",
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          30.sBH,
          audio_waveforms.AudioFileWaveforms(
            playerController: playerState.controller,
            size: const Size(double.infinity, 50),
            enableSeekGesture: true,
            waveformType: audio_waveforms.WaveformType.long,
            continuousWaveform: true,
            playerWaveStyle: audio_waveforms.PlayerWaveStyle(
              fixedWaveColor: Colors.grey,
              liveWaveColor: Colors.white,
              waveThickness: 2.5,
              spacing: 10,
            ),
          ),
          20.sBH,
          Center(
            child: Text(
              formatDuration(playerState.position),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          14.sBH,
          Center(
            child: IconButton.filled(
              style: IconButton.styleFrom(
                foregroundColor: Colors.grey.shade900,
                backgroundColor: Colors.grey.shade400,
              ),
              onPressed: () => context.read<PlayerBloc>().add(PlayPauseAudio()),
              icon: Icon(
                playerState is PlayerPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
