part of 'audio_play_bloc.dart';

enum AudioStatus { loading,play, pause, stop, limitStop }

final class AudioPlayState {
  const AudioPlayState(
      {this.audioStatus = AudioStatus.stop, this.songName = ''});

  final AudioStatus audioStatus;
  final String songName;

  AudioPlayState copyWith({AudioStatus? audioStatus, String? songName}) {
    return AudioPlayState(
        audioStatus: audioStatus = audioStatus ?? this.audioStatus,
        songName: songName = songName ?? this.songName);
  }
}
