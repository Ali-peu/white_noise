import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';
import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';

import 'package:white_noise/white_noice/ui/widgets/audio_card.dart';

class WhiteNoisePage extends StatelessWidget {
  const WhiteNoisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AudioPlayBloc, AudioPlayState>(
        listener: (context, state) {
          if (state.audioStatus == AudioStatus.limitStop) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('The music stopped because of the limit')));
          }
        },
        child: BlocBuilder<AudioManagerBloc, AudioManagerState>(
          builder: (context, state) {
            switch (state.audioPageStatus) {
              case AudioPageStatus.loading:
                {
                  return const Center(child: CircularProgressIndicator());
                }
              case AudioPageStatus.initial:
                {
                  return const Center(child: CircularProgressIndicator());
                }
              case AudioPageStatus.success:
                {
                  return state.music.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return AudioCard(
                              music: state.music[index],
                            );
                          },
                          itemCount: state.music.length,
                        )
                      : const Center(
                          child: Text('NO MUSIC FROM DATA'),
                        );
                }
              case AudioPageStatus.error:
                {
                  return const Center(child: Text('Please refresh page'));
                }
            }
          },
        ),
      ),
    );
  }
}
