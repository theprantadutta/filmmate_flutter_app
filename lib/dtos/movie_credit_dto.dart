import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/movie_credit_dto.g.dart';

@JsonSerializable()
class MovieCreditDto {
  final int id;
  final List<String> writers;
  final List<String> storyBy;
  final List<String> directors;
  final List<String> producers;
  final List<String> musicBy;

  MovieCreditDto({
    required this.id,
    required this.writers,
    required this.storyBy,
    required this.directors,
    required this.producers,
    required this.musicBy,
  });

  /// Connect the generated [_$MovieCreditDtoFromJson] function to the `fromJson`
  /// factory.
  factory MovieCreditDto.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieCreditDtoToJson(this);
}
