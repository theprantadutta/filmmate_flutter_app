import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/cast_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class CastDto {
  final String id;
  final int actorId;
  final bool adult;
  final int gender;
  final String knownForDepartment;
  final String name;
  final double popularity;
  String? profilePath;
  final int castId;
  final String character;
  final int order;

  CastDto({
    required this.id,
    required this.actorId,
    required this.adult,
    required this.gender,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
    required this.castId,
    required this.character,
    required this.order,
  });

  /// Connect the generated [_$CastDtoFromJson] function to the `fromJson`
  /// factory.
  factory CastDto.fromJson(Map<String, dynamic> json) =>
      _$CastDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CastDtoToJson(this);
}
