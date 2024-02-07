class MusicModel {
  final String path;
  final String name;
  final String uid;
  final String imagePath;
  final bool premium;

  MusicModel(
      {required this.path,
      required this.uid,
      required this.imagePath,
      required this.premium,
      required this.name});

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
}
