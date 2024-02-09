import 'package:equatable/equatable.dart';

class MusicModel extends Equatable {
  final String path;
  final String name;
  final String uid;
  final String imagePath;
  final bool premium;

  const MusicModel(
      {required this.path,
      required this.uid,
      required this.imagePath,
      required this.premium,
      required this.name});

  static const empty =
      MusicModel(path: '', uid: '', imagePath: '', premium: false, name: '');

  factory MusicModel.fromJson(Map<String, dynamic> data) {
    return MusicModel(
        path: data['path'],
        uid: data["uid"],
        imagePath: data["imagePath"],
        premium: data[" premium"],
        name: data["name"]);
  }

  @override
  String toString() {
    return "Name $name,uid:$uid";
  }

  @override
  List<Object?> get props => [path, name, uid, imagePath, premium];
}
