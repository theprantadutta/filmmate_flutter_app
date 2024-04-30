class ProductionCompany {
  int id;
  String? logoPath;
  String name;
  String originCountry;

  ProductionCompany(
      {required this.id,
      required this.name,
      required this.originCountry,
      this.logoPath});
}
