import 'package:equatable/equatable.dart';

sealed class DownloadAudioState extends Equatable {}

class DownloadAudioInitial extends DownloadAudioState {
  @override
  List<Object?> get props => [];
}

class DownloadAudioInProgress extends DownloadAudioState {
  @override
  List<Object?> get props => [];
}

class DownloadAudioSuccess extends DownloadAudioState {
  final String filePath;
  DownloadAudioSuccess({required this.filePath});
  @override
  List<Object?> get props => [filePath];
}

class DownloadAudioFailure extends DownloadAudioState {
  final String message;
  DownloadAudioFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
