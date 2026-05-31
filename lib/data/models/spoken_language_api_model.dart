import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';

class SpokenLanguageApiModel {
  final String? englishName;
  final String? iso6391;
  final String? name;

  const SpokenLanguageApiModel({this.englishName, this.iso6391, this.name});

  factory SpokenLanguageApiModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageApiModel(
        englishName: json['english_name'] as String?,
        iso6391: json['iso_639_1'] as String?,
        name: json['name'] as String?,
      );

  SpokenLanguage toDomain() {
    return SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }
}
