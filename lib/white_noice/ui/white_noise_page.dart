import 'dart:developer';

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
          print('HELLOLOLOLOOLOOLOLO');
          log('HELLOLOOLOLO');
          log(state.audioStatus.toString(), name: 'LOGGG');
          if (state.audioStatus == AudioStatus.limitStop) {
            log('The music stopped because of the limit', name: 'Limit LOG');

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('The music stopped because of the limit')));
          }
        },
        child: BlocBuilder<AudioManagerBloc, AudioManagerState>(
          builder: (context, state) {
            return state.songName.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return AudioCard(
                        songName: state.songName[index],
                      );
                    },
                    itemCount: state.songName.length,
                  )
                : const Center(
                    child: Text('Please refresh page'),
                  );
          },
        ),
      ),
    );
  }
}
