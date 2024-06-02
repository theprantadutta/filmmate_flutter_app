import 'package:isar/isar.dart';

import 'movie_detail.dart';
import 'single_image.dart';

part '../generated/entities/images.g.dart';

@collection
class Images {
  Id id = Isar.autoIncrement;

  final backdrops = IsarLinks<SingleImage>();
  final posters = IsarLinks<SingleImage>();
  final logos = IsarLinks<SingleImage>();

  @Backlink(to: 'images')
  final movieDetail = IsarLink<MovieDetail>();
}
