import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/genre_dto.g.dart';

@JsonSerializable()
class GenreDto {
  final int id;
  final String name;

  GenreDto({
    required this.id,
    required this.name,
  });

  /// Connect the generated [_$GenreDtoFromJson] function to the `fromJson`
  /// factory.
  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);
}
