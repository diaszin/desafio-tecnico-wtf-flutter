import 'package:desafio_tecnico_wtf/domain/entities/production_company.dart';

class ProductionCompanyApiModel {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  const ProductionCompanyApiModel({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanyApiModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyApiModel(
        id: json['id'] as int?,
        logoPath: json['logo_path'] as String?,
        name: json['name'] as String?,
        originCountry: json['origin_country'] as String?,
      );

  ProductionCompany toDomain() {
    return ProductionCompany(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }
}
