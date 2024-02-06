import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';

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
              trailing: AbsorbPointer(
                absorbing: state.songName != songName,
                child: IconButton(
                  icon: state.audioStatus == AudioStatus.play &&
                          state.songName == songName
                      ? const Icon(Icons.pause)
                      : (state.audioStatus == AudioStatus.stop &&
                              state.songName == songName
                          ? const Icon(Icons.play_arrow)
                          : const Opacity(opacity: 0.0)),
                  onPressed: () {
                    context
                        .read<AudioPlayBloc>()
                        .add(AudioPauseTapped(songName: songName));
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
