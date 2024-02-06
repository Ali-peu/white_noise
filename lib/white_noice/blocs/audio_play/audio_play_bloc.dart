import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:just_audio/just_audio.dart';

import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';

import 'package:white_noise/white_noice/domain/limited_countdown.dart';
import 'package:white_noise/white_noice/domain/local_notification_servise.dart';

part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  AudioManagerBloc blocValue;

  late bool isMusicPlay;

  final player = AudioPlayer();

  LimitedCountdown countdown = LimitedCountdown();

  AudioPlayBloc({required this.blocValue})
      : super(const AudioPlayState(audioStatus: AudioStatus.stop)) {
    on<AudioPlayTapped>(
        (event, emit) async => await _audioPlayTapped(emit, event));

    on<AudioStopedFromLimits>(
        (event, emit) async => await _audioStoppedFromLimits(emit));

    on<AudioPauseTapped>((event, emit) async => audioPausedTapped(emit, event));
  }

  void audioPausedTapped(
      Emitter<AudioPlayState> emit, AudioPauseTapped event) async {
    if (state.audioStatus == AudioStatus.play) {
      player.stop();
      countdown.stopTimer();
      emit(AudioPlayState(
          audioStatus: AudioStatus.stop, songName: event.songName));
    } else if (state.audioStatus == AudioStatus.pause) {
      player.play();
      emit(AudioPlayState(
          audioStatus: AudioStatus.play, songName: state.songName));
    } else {
      add(AudioPlayTapped(songName: event.songName));
    }
  }

  Future<void> _audioStoppedFromLimits(Emitter<AudioPlayState> emit) async {
    player.stop();
    emit(AudioPlayState(
        audioStatus: AudioStatus.limitStop, songName: state.songName));
    return;
  }

  Future<void> _audioPlayTapped(
      Emitter<AudioPlayState> emit, AudioPlayTapped event) async {
    if (state.audioStatus != AudioStatus.stop) {
      countdown.stopTimer();
    }

    countdown = LimitedCountdown();
    emit(AudioPlayState(
        audioStatus: AudioStatus.loading, songName: event.songName));

    String assetSource =
        blocValue.audioRepository.returnSongs()[event.songName];

    await player.setAsset("assets/$assetSource");
    await player.setLoopMode(LoopMode.all);
    player.play();

    emit(AudioPlayState(
        audioStatus: AudioStatus.play, songName: event.songName));

    isMusicPlay = state.audioStatus == AudioStatus.play;

    log('Just cjeck');

    if (state.audioStatus == AudioStatus.stop) {
      countdown.stopTimer();
    }
    countdown.startTimer(() async {
      log(player.playing.toString(), name: 'Playing status');
      player.stop();
      add(AudioStopedFromLimits(songName: state.songName));
      log(state.audioStatus.toString(),
          name: 'after stop timer into statr timer');
      LocalNotificationService()
          .showNotificationOnLimits('Timer', 'Buy premium');
      isMusicPlay = false;
      countdown.stopTimer();
      return;
    });
  }
}
