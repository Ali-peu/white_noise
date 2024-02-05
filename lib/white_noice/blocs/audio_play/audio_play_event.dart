part of 'audio_play_bloc.dart';

@immutable
sealed class AudioPlayEvent {}

class AudioPlayTapped extends AudioPlayEvent {
  final String songName;
  AudioPlayTapped({required this.songName});
}

class AudioPauseTapped extends AudioPlayEvent{
 final String songName;
  AudioPauseTapped({required this.songName});
}

class AudioStopedFromLimits extends AudioPlayEvent{}