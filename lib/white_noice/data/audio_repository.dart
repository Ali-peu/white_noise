class AudioRepository {
  Map<String, dynamic> returnSongs() {
    // Подготовь на будущее, функционал.
    // Аудио это обьект имеющий путь, название, uid, картинку, и bool параметр premium

    // Создал модель, а репозиторий переписать забыл...
    Map<String, dynamic> songs = {};
    songs['white1'] = 'white_noises/white1.mp3';
    songs['white2'] = 'white_noises/white2.mp3';
    songs['white3'] = 'white_noises/white3.mp3';
    songs['white4'] = 'white_noises/white4.mp3';
    songs['white5'] = 'white_noises/white5.mp3';

    return songs;
  }
}
