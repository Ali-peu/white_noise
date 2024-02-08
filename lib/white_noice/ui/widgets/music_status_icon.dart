import 'package:flutter/material.dart';
import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';

Widget musicStatusIcon(
    AudioStatus audioStatus, String currentPlayMusic, String cardSongName) {
  if (audioStatus == AudioStatus.play && currentPlayMusic == cardSongName) {
    return const Icon(Icons.pause);
  } else if ((audioStatus == AudioStatus.stop ||
          audioStatus == AudioStatus.limitStop) &&
      currentPlayMusic == cardSongName) {
    return const Icon(Icons.play_arrow);
  } else {
    return const SizedBox();
  }
}
