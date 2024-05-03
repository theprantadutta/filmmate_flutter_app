import 'package:json_annotation/json_annotation.dart';

import 'genre_dto.dart';

part '../generated/dtos/movie_dto.g.dart';

@JsonSerializable()
class MovieDto {
  final int id;
  final bool adult;
  String? backdropPath;

  String? posterPath;
  String? releaseDate;

  final String title;
  final int orderBy;

  final List<GenreDto> genres;

  MovieDto({
    required this.id,
    required this.adult,
    required this.title,
    required this.genres,
    required this.orderBy,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
  });

  /// Connect the generated [_$MovieDtoFromJson] function to the `fromJson`
  /// factory.
  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);
}
