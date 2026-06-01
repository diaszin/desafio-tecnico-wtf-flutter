import 'package:desafio_tecnico_wtf/data/models/production_company_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/production_company.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductionCompanyApiModel.fromJson', () {
    test('desserializa todos os campos corretamente', () {
      final json = {
        'id': 1,
        'name': 'Warner Bros.',
        'logo_path': '/logo.png',
        'origin_country': 'US',
      };
      final model = ProductionCompanyApiModel.fromJson(json);

      expect(model.id, equals(1));
      expect(model.name, equals('Warner Bros.'));
      expect(model.logoPath, equals('/logo.png'));
      expect(model.originCountry, equals('US'));
    });

    test('campos ficam null quando ausentes no JSON', () {
      final model = ProductionCompanyApiModel.fromJson({});

      expect(model.id, isNull);
      expect(model.name, isNull);
      expect(model.logoPath, isNull);
      expect(model.originCountry, isNull);
    });

    test('logo_path pode ser null (campo frequentemente nulo na API TMDB)', () {
      final json = {
        'id': 10,
        'name': 'Indie Studio',
        'logo_path': null,
        'origin_country': 'BR',
      };
      final model = ProductionCompanyApiModel.fromJson(json);

      expect(model.logoPath, isNull);
      expect(model.name, equals('Indie Studio'));
    });
  });

  group('ProductionCompanyApiModel.toDomain', () {
    test('converte para ProductionCompany com os mesmos valores', () {
      const model = ProductionCompanyApiModel(
        id: 5,
        name: 'Universal Pictures',
        logoPath: '/universal.png',
        originCountry: 'US',
      );
      final domain = model.toDomain();

      expect(domain, isA<ProductionCompany>());
      expect(domain.id, equals(5));
      expect(domain.name, equals('Universal Pictures'));
      expect(domain.logoPath, equals('/universal.png'));
      expect(domain.originCountry, equals('US'));
    });

    test('converte preservando campos null', () {
      const model = ProductionCompanyApiModel(
        id: null,
        name: null,
        logoPath: null,
        originCountry: null,
      );
      final domain = model.toDomain();

      expect(domain.id, isNull);
      expect(domain.name, isNull);
      expect(domain.logoPath, isNull);
      expect(domain.originCountry, isNull);
    });
  });
}
