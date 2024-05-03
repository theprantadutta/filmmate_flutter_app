import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/spoken_language_dto.g.dart';

@JsonSerializable()
class SpokenLanguageDto {
  late String englishName;
  late String name;

  SpokenLanguageDto({
    required this.englishName,
    required this.name,
  });

  /// Connect the generated [_$SpokenLanguageDtoFromJson] function to the `fromJson`
  /// factory.
  factory SpokenLanguageDto.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SpokenLanguageDtoToJson(this);
}
