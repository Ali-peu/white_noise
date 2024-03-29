import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:just_audio/just_audio.dart';

import 'package:white_noise/white_noice/domain/limited_countdown.dart';
import 'package:white_noise/white_noice/domain/local_notification_servise.dart';
import 'package:white_noise/white_noice/domain/music_model.dart';

part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  final _player = AudioPlayer();

  LimitedCountdown _countdown =
      LimitedCountdown(delay: const Duration(seconds: 5));

  AudioPlayBloc()
      : super(const AudioPlayState(audioStatus: AudioStatus.initial)) {
    on<AudioPlayTapped>(
        (event, emit) async => await _audioPlayTapped(emit, event));
    on<AudioStopedFromLimits>(
        (_, emit) async => await _audioStoppedFromLimits(emit));
    on<AudioPauseTapped>((event, emit) async => audioPausedTapped(emit, event));

    _player.setLoopMode(LoopMode.all);
  }

  void audioPausedTapped(
      Emitter<AudioPlayState> emit, AudioPauseTapped event) async {
    if (state.audioStatus == AudioStatus.play) {
      if (state.music == event.music) {
        await Future.wait([_player.stop(), _countdown.stopTimer()]);

        emit(AudioPlayState(audioStatus: AudioStatus.stop, music: state.music));
      }
    }
  }

  Future<void> _audioStoppedFromLimits(Emitter<AudioPlayState> emit) async {
    await Future.wait([_player.stop(), _countdown.stopTimer()]);
    emit(
        AudioPlayState(audioStatus: AudioStatus.limitStop, music: state.music));
  }

  Future<void> callback(AudioPlayer audioPlayer, MusicModel music) async {
    add(AudioStopedFromLimits(music: music));
    LocalNotificationService().showNotificationOnLimits('Timer', 'Buy premium');
    return;
  }

  Future<void> _audioPlayTapped(
      Emitter<AudioPlayState> emit, AudioPlayTapped event) async {
    // emit(const AudioPlayState().copyWith());
    if (state.audioStatus == AudioStatus.play) {
      if (state.music == event.music) {
        // Если музыка уже воспроизводится, стопим его , а в евенте pauseTapped таймер стопиться
        add(AudioPauseTapped(music: event.music));
      } else {
        // Если выбрана новая музыка, останавливаем текущую и запускаем новую
        await Future.wait([_player.stop(), _countdown.stopTimer()]);
        _countdown = LimitedCountdown(delay: const Duration(seconds: 5));

        emit(AudioPlayState(audioStatus: AudioStatus.play, music: event.music));
        String assetSource = event.music.path;
        await _player.setAsset("assets/$assetSource");

        _player.play();

        _countdown.startTimer(() async {
          callback(_player, state.music);
        });
      }
    } else {
      // Если нет активного воспроизведения, начинаем воспроизведение
      _countdown = LimitedCountdown(delay: const Duration(seconds: 5));

      emit(AudioPlayState(audioStatus: AudioStatus.play, music: event.music));

      String assetSource = event.music.path;
      await _player.setAsset("assets/$assetSource");

      _player.play();

      _countdown.startTimer(() async {
        await callback(_player, state.music);
      });
    }
  }
}
