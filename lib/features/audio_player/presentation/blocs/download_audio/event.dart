import 'package:equatable/equatable.dart';

sealed class DownloadAudioEvent extends Equatable {}

class StartAudioDownload extends DownloadAudioEvent {
  final String url;
  StartAudioDownload({required this.url});
  @override
  List<Object?> get props => [url];
}
