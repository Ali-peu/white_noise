import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:white_noise/simple_bloc_observer.dart';
import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';
import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';
import 'package:white_noise/white_noice/domain/local_notification_servise.dart';

import 'package:white_noise/white_noice/ui/white_noise_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DetailedBlocObserver();
  LocalNotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AudioManagerBloc audioManagerBloc = AudioManagerBloc();

    AudioPlayBloc audioPlayBloc = AudioPlayBloc();

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: audioManagerBloc..add(OnPageOpened())),
          BlocProvider.value(value: audioPlayBloc),
        ],
        child: const WhiteNoisePage(),
      ),
    );
  }
}
