import 'package:flutter/material.dart';
import 'package:white_noise/white_noice/blocs/audio_play/audio_play_bloc.dart';

// Не передавай ему весь AudioPlayState если требуется ему только одно свойство,
// передавай сразу свойство
Widget validator(AudioPlayState state, String songName) {
  Widget icon;
  // Используй if, хоть тернарный оператор и считается немного более быстрым,
  // Подобные конструкции как в данном случае, очень не удобны для быстро чтения,
  // из за чего легко совершить логическую ошибку.
  (state.audioStatus == AudioStatus.play && state.songName == songName)
      ? icon = const Icon(Icons.pause)
      : ((state.audioStatus == AudioStatus.pause && state.songName == songName)
          ? icon = const Icon(Icons.play_arrow)
          : icon = const Visibility(visible: false, child: Icon(Icons.stop)));
  return icon;
}
