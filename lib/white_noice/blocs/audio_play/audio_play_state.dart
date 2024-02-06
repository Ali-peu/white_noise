part of 'audio_play_bloc.dart';

enum AudioStatus { loading, play, pause, stop, limitStop }

final class AudioPlayState extends Equatable {
  const AudioPlayState(
      {this.audioStatus = AudioStatus.stop, this.songName = ''});

  final AudioStatus audioStatus;
  final String songName;

  AudioPlayState copyWith(
      {AudioStatus? audioStatus, String? songName, bool? musicIsPlaying}) {
    return AudioPlayState(
        audioStatus: audioStatus = audioStatus ?? this.audioStatus,
        songName: songName = songName ?? this.songName);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [audioStatus, songName];
}
