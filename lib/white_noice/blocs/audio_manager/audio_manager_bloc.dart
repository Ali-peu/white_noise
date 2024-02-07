import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:white_noise/white_noice/data/audio_repository.dart';

part 'audio_manager_event.dart';
part 'audio_manager_state.dart';

class AudioManagerBloc extends Bloc<AudioManagerEvent, AudioManagerState> {
  AudioRepository audioRepository = AudioRepository();

  AudioManagerBloc()
      : super(
            const AudioManagerState(audioPageStatus: AudioPageStatus.initial)) {
    // вынеси в метод
    on<OnPageOpened>(
        (event, emit) => _onPageOpened(event, emit, audioRepository));
  }
}

Future<void> _onPageOpened(OnPageOpened event, Emitter<AudioManagerState> emit,
    AudioRepository audioRepository) async {
  
  emit(const AudioManagerState(
      audioPageStatus: AudioPageStatus.initial, songName: []));

  List<String> songs = audioRepository.returnSongs().keys.toList();
  emit(AudioManagerState(
      audioPageStatus: AudioPageStatus.success, songName: songs));
}
