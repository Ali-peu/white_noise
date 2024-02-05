import 'dart:developer';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';
import 'package:audioplayers/audioplayers.dart';


part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  AudioManagerBloc blocValue;

  final player = AudioPlayer();

  AudioPlayBloc({required this.blocValue})
      : super(const AudioPlayState(audioStatus: AudioStatus.stop)) {
    on<AudioPlayTapped>((event, emit) async {
      emit(AudioPlayState(
          audioStatus: AudioStatus.play, songName: event.songName));
      log(blocValue.audioRepository.returnSongs()[event.songName],
          name: 'Found music log: ');

      final receivePort = ReceivePort();

      await Isolate.spawn(goLimitTime, receivePort.sendPort);

      receivePort.listen((message) {
        print(message);
        log(message, name: "ReceivePort mmessages");
        return add(AudioStopedFromLimits());
      });
      String assetSource =
          blocValue.audioRepository.returnSongs()[event.songName];

      await player.play(AssetSource(assetSource));

      player.onPlayerComplete.listen((event) {
        player.play(
          AssetSource(assetSource),
        );
      });
    });

    on<AudioStopedFromLimits>((event, emit) async {
      print('ITS AudioStopedFromLimits COMPLATED ');
      await player.stop();
      emit(const AudioPlayState(audioStatus: AudioStatus.limitStop));
    });

    on<AudioPauseTapped>((event, emit) async {
      if (state.audioStatus == AudioStatus.play) {
        // await player.pause();
        emit(AudioPlayState(
            audioStatus: AudioStatus.pause, songName: event.songName));
      } else if (state.audioStatus == AudioStatus.pause) {
        add(AudioPlayTapped(songName: event.songName));
      } else {
        log('ITS AudioPauseTapped else situation', name: 'ELSE LOG');
        add(AudioPlayTapped(songName: event.songName));
      }
    });
  }
}

goLimitTime(SendPort sendPort) async {
  await Future.delayed(const Duration(seconds: 10));
  print('Time IS GONE');
  log('TIME IS GONE LOG', name: "goLimitTime(sendPort)");
  sendPort.send('TIME IS GONE');
}
