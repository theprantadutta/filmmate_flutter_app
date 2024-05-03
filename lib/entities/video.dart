import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/video.g.dart';

@collection
class Video {
  Id autoId = Isar.autoIncrement;

  late String id;
  late String name;
  late String key;
  late String site;
  late int size;
  late String type;
  late bool official;
  late DateTime publishedAt;

  @Backlink(to: 'videos')
  final movieDetail = IsarLink<MovieDetail>();
}
