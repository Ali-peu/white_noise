part of 'audio_play_bloc.dart';

enum AudioStatus { initial, loading, play, pause, stop, limitStop, trackChange }

final class AudioPlayState extends Equatable {
  const AudioPlayState(
      {this.audioStatus = AudioStatus.initial, this.music = MusicModel.empty});

  final AudioStatus audioStatus;
  final MusicModel music;

  AudioPlayState copyWith({AudioStatus? audioStatus, MusicModel? music}) {
    return AudioPlayState(
        audioStatus: audioStatus = audioStatus ?? this.audioStatus,
        music: music = music ?? this.music);
  }

  @override
  List<Object?> get props => [audioStatus, music];
}
