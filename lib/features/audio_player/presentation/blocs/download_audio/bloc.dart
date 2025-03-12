import 'dart:async';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/event.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/state.dart';
import 'package:audio_player/utils/audio_downloader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadAudioBloc extends Bloc<DownloadAudioEvent, DownloadAudioState> {
  DownloadAudioBloc() : super(DownloadAudioInitial()) {
    on<StartAudioDownload>(_startAudioDownload);
  }

  FutureOr<void> _startAudioDownload(
    StartAudioDownload event,
    Emitter<DownloadAudioState> emit,
  ) async {
    try {
      emit(DownloadAudioInProgress());
      // Download audio file
      final file = await AudioDownloader().downloadAudio(event.url);
      emit(DownloadAudioSuccess(filePath: file!.path));
    } catch (e) {
      emit(DownloadAudioFailure(message: e.toString()));
    }
  }
}
