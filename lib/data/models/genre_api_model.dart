import 'package:desafio_tecnico_wtf/domain/entities/genre.dart';

class GenreApiModel {
  final int? id;
  final String? name;

  const GenreApiModel({this.id, this.name});

  factory GenreApiModel.fromJson(Map<String, dynamic> json) =>
      GenreApiModel(id: json['id'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  Genre toDomain() {
    return Genre(id: id, name: name);
  }
}
