import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class InitializePlayer extends PlayerEvent {
  final String path;
  const InitializePlayer({required this.path});

  @override
  List<Object?> get props => [path];
}

class PlayPauseAudio extends PlayerEvent {}

class PlayerCompleted extends PlayerEvent {}

class UpdatePosition extends PlayerEvent {
  final int position;
  const UpdatePosition({required this.position});

  @override
  List<Object?> get props => [position];
}
