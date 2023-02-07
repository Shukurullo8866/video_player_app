class MusicModel{
  String path;
  bool isPlaying = false;
  bool isPaused = false;
  String name;
  String author;
  String image;

  MusicModel({
    required this.image,
    required this.name,
    required this.path,
    required this.author
  });
}