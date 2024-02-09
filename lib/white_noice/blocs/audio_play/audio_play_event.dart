part of 'audio_play_bloc.dart';

@immutable
sealed class AudioPlayEvent extends Equatable {}

class AudioPlayTapped extends AudioPlayEvent {
  final MusicModel music;

  AudioPlayTapped({required this.music});

  @override
  List<Object?> get props => [music];
}

class AudioPauseTapped extends AudioPlayEvent {
  final MusicModel music;
  AudioPauseTapped({required this.music});

  @override
  List<Object?> get props => [music];
}

class AudioStopedFromLimits extends AudioPlayEvent {
  final MusicModel music;
  AudioStopedFromLimits({required this.music});
  @override
  List<Object?> get props => [music];
}
