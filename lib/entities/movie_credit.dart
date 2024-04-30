class MovieCredit {
  int id;
  List<String> writers;
  List<String> storyBy;
  List<String> directors;
  List<String> producers;
  List<String> musicBy;

  MovieCredit({
    required this.id,
    required this.writers,
    required this.storyBy,
    required this.directors,
    required this.producers,
    required this.musicBy,
  });
}
