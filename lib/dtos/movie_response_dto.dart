import 'package:json_annotation/json_annotation.dart';

import 'movie_dto.dart';
import 'pagination_dto.dart';

part '../generated/dtos/movie_response_dto.g.dart';

@JsonSerializable()
class MovieResponseDto {
  final List<MovieDto> movies;
  final PaginationDto pagination;

  MovieResponseDto({
    required this.movies,
    required this.pagination,
  });

  /// Connect the generated [_$MovieResponseDtoFromJson] function to the `fromJson`
  /// factory.
  factory MovieResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseDtoFromJson(json);

  /// Connect the generated [_$MovieResponseDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieResponseDtoToJson(this);
}
