import 'dart:async';
import 'package:audio_player/features/audio_player/presentation/blocs/player/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/state.dart';
import 'package:audio_waveforms/audio_waveforms.dart' hide PlayerState;

import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  late PlayerController _playerController;
  String? _audioPath;
  StreamSubscription<int>? _positionSubscription;

  PlayerBloc() : super(PlayerInitial()) {
    _playerController = PlayerController();

    on<InitializePlayer>((event, emit) {
      _audioPath = event.path;
      _playerController.preparePlayer(path: _audioPath!);

      // Listen for completion and reset player state
      _playerController.onCompletion.listen((_) {
        add(PlayerCompleted());
      });

      // Listen for position updates
      _startListeningToPosition();

      emit(PlayerReady(_playerController, 0, _playerController.maxDuration));
    });

    on<PlayPauseAudio>((event, emit) async {
      if (state is PlayerPlaying) {
        await _playerController.pausePlayer();
        emit(PlayerPaused(_playerController, state.position, state.duration));
      } else {
        await _playerController.startPlayer();
        emit(PlayerPlaying(_playerController, state.position, state.duration));
      }
    });

    on<UpdatePosition>((event, emit) {
      emit(
        PlayerPlaying(
          _playerController,
          event.position,
          _playerController.maxDuration,
        ),
      );
    });

    on<PlayerCompleted>((event, emit) {
      _playerController.seekTo(0);
      emit(PlayerStopped(_playerController, 0, _playerController.maxDuration));
    });
  }

  /// Starts listening to `onCurrentDuration` to track playback progress
  void _startListeningToPosition() {
    _positionSubscription?.cancel();
    _positionSubscription = _playerController.onCurrentDurationChanged.listen((
      position,
    ) {
      add(UpdatePosition(position: position));
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _playerController.dispose();
    return super.close();
  }
}




