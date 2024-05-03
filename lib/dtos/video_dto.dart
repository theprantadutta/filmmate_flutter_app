import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/video_dto.g.dart';

@JsonSerializable()
class VideoDto {
  final String id;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;

  VideoDto({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  /// Connect the generated [_$VideoDtoFromJson] function to the `fromJson`
  /// factory.
  factory VideoDto.fromJson(Map<String, dynamic> json) =>
      _$VideoDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VideoDtoToJson(this);
}
