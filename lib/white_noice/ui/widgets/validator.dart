import 'package:flutter/material.dart';
import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';

Widget validator(AudioPlayState state, String songName) {
  Widget icon;
  (state.audioStatus == AudioStatus.play && state.songName == songName)
      ? icon = const Icon(Icons.pause)
      : ((state.audioStatus == AudioStatus.pause && state.songName == songName)
          ? icon = const Icon(Icons.play_arrow)
          : icon = const Visibility(visible: false, child: Icon(Icons.stop)));
  return icon;
}
