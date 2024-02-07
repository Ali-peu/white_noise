part of 'audio_play_bloc.dart';

enum AudioStatus { initial, loading, play, pause, stop, limitStop, trackChange }

final class AudioPlayState extends Equatable {
  const AudioPlayState(
      {this.audioStatus = AudioStatus.initial, this.songName = ''});

  final AudioStatus audioStatus;
  final String songName;

  AudioPlayState copyWith({AudioStatus? audioStatus, String? songName}) {
    return AudioPlayState(
        audioStatus: audioStatus = audioStatus ?? this.audioStatus,
        songName: songName = songName ?? this.songName);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [audioStatus, songName];
}
