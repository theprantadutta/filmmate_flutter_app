import 'package:json_annotation/json_annotation.dart';

import 'image_dto.dart';

part '../generated/dtos/images_dto.g.dart';

@JsonSerializable()
class ImagesDto {
  final List<ImageDto> backdrops;
  final List<ImageDto> posters;
  final List<ImageDto> logos;

  ImagesDto({
    required this.backdrops,
    required this.posters,
    required this.logos,
  });

  /// Connect the generated [_$ImagesDtoFromJson] function to the `fromJson`
  /// factory.
  factory ImagesDto.fromJson(Map<String, dynamic> json) =>
      _$ImagesDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ImagesDtoToJson(this);
}
