import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:white_noise/white_noice/data/stream_30_minut.dart';

part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  AudioManagerBloc blocValue;
  TimerIsolate timerIsolate;

  final player = AudioPlayer();

  AudioPlayBloc({required this.blocValue})
      : timerIsolate = TimerIsolate(),
        super(const AudioPlayState(audioStatus: AudioStatus.stop)) {
    on<AudioPlayTapped>((event, emit) async {
      if (!(timerIsolate.isClosed)) {
        log(timerIsolate.isClosed.toString(), name: "AudioPlayBloc if first");
        timerIsolate.stopTimer();
        log(timerIsolate.isClosed.toString(), name: "AudioPlayBloc if second");
      }
      emit(AudioPlayState(
          audioStatus: AudioStatus.play, songName: event.songName));
      log(blocValue.audioRepository.returnSongs()[event.songName],
          name: 'Found music log: ');

      String assetSource =
          blocValue.audioRepository.returnSongs()[event.songName];

      timerIsolate.startTimer();
      await player.play(AssetSource(assetSource));

      timerIsolate.timerStream.listen((event) async {
        await player.pause();
        add(AudioStopedFromLimits());
        log('Event int < 5 ', name: 'Timer < 5 LOG');
      });

      print(timerIsolate);
      log(timerIsolate.toString());

      player.onPlayerComplete.listen((event) {
        player.play(
          AssetSource(assetSource),
        );
      });
    });

    on<AudioStopedFromLimits>((event, emit) async {
      print('ITS AudioStopedFromLimits COMPLATED ');
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
