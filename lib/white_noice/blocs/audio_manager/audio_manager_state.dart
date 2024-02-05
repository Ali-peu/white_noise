part of 'audio_manager_bloc.dart';

// enum AudioStatus { play, pause, stop }

enum AudioPageStatus {
  initial,
  loading,
  error,
  success,
}

final class AudioManagerState {
  const AudioManagerState(
      {this.songName = const [],
      this.audioPageStatus = AudioPageStatus.initial});

  final List<String> songName;
  final AudioPageStatus audioPageStatus;

  AudioManagerState copyWith({
    List<String>? songName,
    AudioPageStatus? audioPageStatus,
  }) {
    return AudioManagerState(
        songName: songName = songName ?? this.songName,
        audioPageStatus: audioPageStatus =
            audioPageStatus ?? this.audioPageStatus);
  }
}
