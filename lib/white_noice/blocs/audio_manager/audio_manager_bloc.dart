import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:white_noise/white_noice/data/audio_repository.dart';

part 'audio_manager_event.dart';
part 'audio_manager_state.dart';

class AudioManagerBloc extends Bloc<AudioManagerEvent, AudioManagerState> {
  AudioRepository audioRepository = AudioRepository();

  AudioManagerBloc()
      : super(
            const AudioManagerState(audioPageStatus: AudioPageStatus.initial)) {
    on<AudioManagerEvent>((event, emit) {
      print('${audioRepository.returnSongs().keys.first}');
    });

    on<OnPageOpened>((event, emit) {
      emit(const AudioManagerState(
          audioPageStatus: AudioPageStatus.initial, songName: []));

      List<String> songs = audioRepository.returnSongs().keys.toList();
      emit(AudioManagerState(
          audioPageStatus: AudioPageStatus.success, songName: songs));
    });
  }
}
