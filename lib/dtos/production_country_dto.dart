import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/production_country_dto.g.dart';

@JsonSerializable()
class ProductionCountryDto {
  final int id;
  final String name;

  ProductionCountryDto({
    required this.id,
    required this.name,
  });

  /// Connect the generated [_$ProductionCountryDtoFromJson] function to the `fromJson`
  /// factory.
  factory ProductionCountryDto.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductionCountryDtoToJson(this);
}
