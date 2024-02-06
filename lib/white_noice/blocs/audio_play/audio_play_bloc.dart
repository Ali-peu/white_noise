import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:white_noise/white_noice/blocs/audio_manager/audio_manager_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:white_noise/white_noice/domain/limited_countdown.dart';

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
      countdown.pauseTimer();
      await player.pause();
      emit(AudioPlayState(
          audioStatus: AudioStatus.pause, songName: event.songName));
    } else if (state.audioStatus == AudioStatus.pause) {
      countdown.resumeTimer();
      await player.resume();
      emit(AudioPlayState(
          audioStatus: AudioStatus.play, songName: state.songName));
    } else {
      add(AudioPlayTapped(songName: event.songName));
    }
  }

  Future<void> _audioStoppedFromLimits(Emitter<AudioPlayState> emit) async {
    await player.stop();
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

    await player.play(AssetSource(assetSource));

    emit(AudioPlayState(
        audioStatus: AudioStatus.play, songName: event.songName));

    state.audioStatus == AudioStatus.play
        ? isMusicPlay = true
        : isMusicPlay = false;

    countdown.startTimer(() async {
      await player.pause();
      add(AudioStopedFromLimits(songName: state.songName));
      isMusicPlay = false;
    });

    player.onPlayerComplete.listen((event) {
      player.play(
        AssetSource(assetSource),
      );
    });
  }
}
