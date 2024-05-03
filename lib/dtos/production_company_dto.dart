import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/production_company_dto.g.dart';

@JsonSerializable()
class ProductionCompanyDto {
  final int id;
  String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanyDto({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  /// Connect the generated [_$ProductionCompanyDtoFromJson] function to the `fromJson`
  /// factory.
  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductionCompanyDtoToJson(this);
}
