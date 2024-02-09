import 'package:white_noise/white_noice/domain/music_model.dart';

class AudioRepository {
  List<MusicModel> songs = [];

  AudioRepository();
  Future<List<MusicModel>> returnSongs() async {
    // Подготовь на будущее, функционал.
    // Аудио это обьект имеющий путь, название, uid, картинку, и bool параметр premium
    // Тут я как понимаю будет запрос в сервер, и получаю json
    // И из json все данные добавлю в songs
    // Это функцию я буду вызывать в блоке что получить данные при открытие страницы

    songs.add(const MusicModel(
        path: 'white_noises/white1.mp3',
        uid: "null",
        imagePath: 'null',
        premium: false,
        name: "white1"));

    songs.add(const MusicModel(
        path: 'white_noises/white2.mp3',
        uid: "null",
        imagePath: 'null',
        premium: false,
        name: "white2"));
    songs.add(const MusicModel(
        path: 'white_noises/white3.mp3',
        uid: "null",
        imagePath: 'null',
        premium: false,
        name: "white3"));
    songs.add(const MusicModel(
        path: 'white_noises/white4.mp3',
        uid: "null",
        imagePath: 'null',
        premium: false,
        name: "white4"));
    songs.add(const MusicModel(
        path: 'white_noises/white5.mp3',
        uid: "null",
        imagePath: 'null',
        premium: false,
        name: "white5"));

    return songs;
  }
}
