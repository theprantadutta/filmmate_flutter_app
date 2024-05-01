import 'package:isar/isar.dart';

import 'images.dart';

part '../generated/entities/image.g.dart';

@collection
class Image {
  Id autoId = Isar.autoIncrement;

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
