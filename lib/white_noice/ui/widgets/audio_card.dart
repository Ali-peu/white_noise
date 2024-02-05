import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';
import 'package:white_noise/white_noice/ui/widgets/validator.dart';

class AudioCard extends StatelessWidget {
  final String songName;
  const AudioCard({required this.songName, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayBloc, AudioPlayState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context
                .read<AudioPlayBloc>()
                .add(AudioPlayTapped(songName: songName)); // TODO
          },
          child: Card(
            child: ListTile(
              title: Text(songName),
              trailing: IconButton(
                icon: validator(state, songName), // TODO
                onPressed: () {
                  context
                      .read<AudioPlayBloc>()
                      .add(AudioPauseTapped(songName: songName));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
