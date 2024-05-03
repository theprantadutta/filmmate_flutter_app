import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/image_dto.g.dart';

@JsonSerializable()
class ImageDto {
  final double aspectRatio;
  final int height;
  final int width;
  String? filePath;

  ImageDto({
    required this.aspectRatio,
    required this.height,
    required this.width,
    this.filePath,
  });

  /// Connect the generated [_$ImageDtoFromJson] function to the `fromJson`
  /// factory.
  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);
}
