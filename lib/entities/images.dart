import 'package:isar/isar.dart';

import 'image.dart';
import 'movie.dart';

part '../generated/entities/images.g.dart';

@collection
class Images {
  Id autoId = Isar.autoIncrement;

  final backdrops = IsarLinks<Image>();
  final posters = IsarLinks<Image>();
  final logos = IsarLinks<Image>();

  @Backlink(to: 'images')
  final movie = IsarLink<Movie>();
}
