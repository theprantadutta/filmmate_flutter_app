import 'package:isar/isar.dart';

import '../util/functions.dart';
import 'movie_detail.dart';

part '../generated/entities/video.g.dart';

@collection
class Video {
  String? id;
  Id get isarId => fastHash(id!);

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
