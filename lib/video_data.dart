enum VideoType {
  asset,
  file,
  network,
  recorded,
}

class VideoData {
  int id;
  final String name;
  final String path;
  final String image;
  final VideoType type;

  VideoData({
    this.id,
    this.name,
    this.path,
    this.image,
    this.type,

  });
}
