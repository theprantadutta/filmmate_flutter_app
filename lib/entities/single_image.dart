import 'package:isar/isar.dart';

import 'images.dart';

part '../generated/entities/single_image.g.dart';

@collection
class SingleImage {
  Id id = Isar.autoIncrement;

  late double aspectRatio;
  late int height;
  late int width;
  late String? filePath;

  @Backlink(to: 'backdrops')
  final backdropImages = IsarLink<Images>();

  @Backlink(to: 'posters')
  final posterImages = IsarLink<Images>();

  @Backlink(to: 'logos')
  final logoImages = IsarLink<Images>();
}
