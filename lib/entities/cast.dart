import 'package:isar/isar.dart';

import '../util/functions.dart';
import 'movie_detail.dart';

part '../generated/entities/cast.g.dart';

@collection
class Cast {
  String? id;
  Id get isarId => fastHash(id!);

  late int actorId;
  late bool adult;
  late int gender;
  late String knownForDepartment;
  late String name;
  late double popularity;
  late String? profilePath;
  late int castId;
  late String character;
  late int order;

  @Backlink(to: 'casts')
  final movieDetail = IsarLink<MovieDetail>();
}
