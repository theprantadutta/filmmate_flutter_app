class Video {
  String id;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  DateTime publishedAt;

  Video({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });
}
