import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:equatable/equatable.dart';

abstract class PlayerState extends Equatable {
  const PlayerState(this.controller, this.position, this.duration);

  final PlayerController controller;
  final int position;
  final int duration;

  @override
  List<Object?> get props => [controller, position, duration];
}

class PlayerInitial extends PlayerState {
  PlayerInitial() : super(PlayerController(), 0, 0);
}

class PlayerReady extends PlayerState {
  const PlayerReady(super.controller, super.position, super.duration);
}

class PlayerPlaying extends PlayerState {
  const PlayerPlaying(super.controller, super.position, super.duration);
}

class PlayerPaused extends PlayerState {
  const PlayerPaused(super.controller, super.position, super.duration);
}

class PlayerStopped extends PlayerState {
  const PlayerStopped(super.controller, super.position, super.duration);
}

class PlayerCompletedState extends PlayerState {
  const PlayerCompletedState(super.controller, super.position, super.duration);
}
