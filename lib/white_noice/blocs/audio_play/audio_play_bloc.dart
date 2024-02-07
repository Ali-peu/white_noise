import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:just_audio/just_audio.dart';

import 'package:white_noise/white_noice/data/audio_repository.dart';

import 'package:white_noise/white_noice/domain/limited_countdown.dart';
import 'package:white_noise/white_noice/domain/local_notification_servise.dart';

part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  AudioRepository audioRepository;

  final player = AudioPlayer();

  LimitedCountdown countdown = LimitedCountdown();

  AudioPlayBloc({required this.audioRepository})
      : super(const AudioPlayState(audioStatus: AudioStatus.initial)) {
    on<AudioPlayTapped>(
        (event, emit) async => await _audioPlayTapped(emit, event));
    on<AudioStopedFromLimits>(
        (_, emit) async => await _audioStoppedFromLimits(emit));
    on<AudioPauseTapped>((event, emit) async => audioPausedTapped(emit, event));

    player.setLoopMode(LoopMode.all);
  }

  void audioPausedTapped(
      Emitter<AudioPlayState> emit, AudioPauseTapped event) async {
    if (state.audioStatus == AudioStatus.play) {
      if (state.songName == event.songName) {
        player.stop();
        countdown.stopTimer();
        emit(AudioPlayState(
            audioStatus: AudioStatus.stop, songName: state.songName));
      }
    } else {
      add(AudioPlayTapped(songName: event.songName));
    }
  }

  Future<void> _audioStoppedFromLimits(Emitter<AudioPlayState> emit) async {
    await player.stop();

    countdown.stopTimer();

    emit(AudioPlayState(
        audioStatus: AudioStatus.limitStop, songName: state.songName));
    return;
  }

  Future<void> _audioPlayTapped(
      Emitter<AudioPlayState> emit, AudioPlayTapped event) async {
    if (state.audioStatus == AudioStatus.play) {
      if (state.songName == event.songName) {
        add(AudioPauseTapped(songName: event.songName));

        return;
      } else {
        player.stop();
        countdown.stopTimer();
        emit(AudioPlayState(
            audioStatus: AudioStatus.trackChange, songName: event.songName));
        add(AudioPlayTapped(songName: event.songName));
      }
    } else {
      countdown = LimitedCountdown();

      emit(AudioPlayState(
          audioStatus: AudioStatus.loading, songName: event.songName));

      String assetSource = audioRepository.returnSongs()[event.songName];

      await player.setAsset("assets/$assetSource");

      emit(AudioPlayState(
          audioStatus: AudioStatus.play, songName: event.songName));

      player.play();

      countdown.startTimer(() async {
        callback(player, state.songName);
      });
    }
  }

  void callback(AudioPlayer audioPlayer, String songName) async {
    await audioPlayer.stop();

    add(AudioStopedFromLimits(songName: songName));
    LocalNotificationService().showNotificationOnLimits('Timer', 'Buy premium');

    countdown.stopTimer();
    return;
  }
}
