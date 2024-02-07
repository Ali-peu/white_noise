part of 'audio_play_bloc.dart';

@immutable
sealed class AudioPlayEvent extends Equatable {}

class AudioPlayTapped extends AudioPlayEvent {
  final String songName;
  AudioPlayTapped({required this.songName});

  @override
  List<Object?> get props => [songName];
}

class AudioPauseTapped extends AudioPlayEvent {
  final String songName;
  AudioPauseTapped({required this.songName});

  @override
  List<Object?> get props => [songName];
}

class AudioStopedFromLimits extends AudioPlayEvent {
  final String songName;
  AudioStopedFromLimits({required this.songName});
  @override
  List<Object?> get props => [songName];
}
