part of 'audio_manager_bloc.dart';

// enum AudioStatus { play, pause, stop }

enum AudioPageStatus {
  initial,
  loading,
  error,
  success,
}

final class AudioManagerState extends Equatable {
  const AudioManagerState(
      {this.music = const [],
      this.audioPageStatus = AudioPageStatus.initial});

  final List<MusicModel> music;
  final AudioPageStatus audioPageStatus;

  AudioManagerState copyWith({
    List<MusicModel>? music,
    AudioPageStatus? audioPageStatus,
  }) {
    return AudioManagerState(
        music: music = music ?? this.music,
        audioPageStatus: audioPageStatus =
            audioPageStatus ?? this.audioPageStatus);
  }

  @override
  List<Object?> get props => [music, audioPageStatus];
}
