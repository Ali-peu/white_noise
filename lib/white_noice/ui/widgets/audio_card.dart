import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';
import 'package:white_noise/white_noice/ui/widgets/music_status_icon.dart';

class AudioCard extends StatelessWidget {
  final String songName;

  const AudioCard({required this.songName, super.key});

  // Давай перепишем функционал, что обходиться без нажатия именно на иконку,
  // То есть работаем только с нажатием на всё поле, и там уже происходит переключение
  // с Play на Pause.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayBloc, AudioPlayState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context
                .read<AudioPlayBloc>()
                .add(AudioPlayTapped(songName: songName));
          },
          child: Card(
            child: ListTile(
              title: Text(songName),
              trailing:
                  musicStatusIcon(state.audioStatus, state.songName, songName),
            ),
          ),
        );
      },
    );
  }
}
