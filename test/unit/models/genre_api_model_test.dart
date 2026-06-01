import 'package:desafio_tecnico_wtf/data/models/genre_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenreApiModel.fromJson', () {
    test('desserializa id e name corretamente', () {
      final json = {'id': 28, 'name': 'Action'};
      final model = GenreApiModel.fromJson(json);

      expect(model.id, equals(28));
      expect(model.name, equals('Action'));
    });

    test('id null quando ausente no JSON', () {
      final json = {'name': 'Drama'};
      final model = GenreApiModel.fromJson(json);

      expect(model.id, isNull);
      expect(model.name, equals('Drama'));
    });

    test('name null quando ausente no JSON', () {
      final json = {'id': 99};
      final model = GenreApiModel.fromJson(json);

      expect(model.id, equals(99));
      expect(model.name, isNull);
    });
  });

  group('GenreApiModel.toJson', () {
    test('serializa id e name corretamente', () {
      const model = GenreApiModel(id: 28, name: 'Action');
      final json = model.toJson();

      expect(json['id'], equals(28));
      expect(json['name'], equals('Action'));
    });

    test('serializa campos null corretamente', () {
      const model = GenreApiModel(id: null, name: null);
      final json = model.toJson();

      expect(json['id'], isNull);
      expect(json['name'], isNull);
    });
  });

  group('GenreApiModel.toDomain', () {
    test('converte para Genre com os mesmos valores', () {
      const model = GenreApiModel(id: 28, name: 'Action');
      final domain = model.toDomain();

      expect(domain, isA<Genre>());
      expect(domain.id, equals(28));
      expect(domain.name, equals('Action'));
    });

    test('converte para Genre preservando campos null', () {
      const model = GenreApiModel(id: null, name: null);
      final domain = model.toDomain();

      expect(domain.id, isNull);
      expect(domain.name, isNull);
    });
  });
}
