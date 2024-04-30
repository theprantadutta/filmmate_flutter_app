class Cast {
  String id;
  int actorId;
  bool adult;
  int gender;
  String knownForDepartment;
  String name;
  double popularity;
  String? profilePath;
  int castId;
  String character;
  int order;

  Cast({
    required this.id,
    required this.actorId,
    required this.adult,
    required this.gender,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.castId,
    required this.character,
    required this.order,
    this.profilePath,
  });
}
