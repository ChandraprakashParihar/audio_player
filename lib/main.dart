import 'package:audio_player/core/theme.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/download_audio/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/blocs/player/bloc.dart';
import 'package:audio_player/features/audio_player/presentation/view/screens/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(AudioPlayerApp());
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

class AudioPlayerApp extends StatelessWidget {
  const AudioPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Player',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DownloadAudioBloc>(
            create: (context) => DownloadAudioBloc(),
          ),
          BlocProvider(create: (context) => PlayerBloc()),
        ],

        child: AudioPlayerScreen(),
      ),
    );
  }
}
