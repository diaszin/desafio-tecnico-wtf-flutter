import 'package:desafio_tecnico_wtf/data/models/spoken_language_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpokenLanguageApiModel.fromJson', () {
    test('desserializa todos os campos corretamente', () {
      final json = {
        'english_name': 'English',
        'iso_639_1': 'en',
        'name': 'English',
      };
      final model = SpokenLanguageApiModel.fromJson(json);

      expect(model.englishName, equals('English'));
      expect(model.iso6391, equals('en'));
      expect(model.name, equals('English'));
    });

    test('campos ficam null quando ausentes no JSON', () {
      final model = SpokenLanguageApiModel.fromJson({});

      expect(model.englishName, isNull);
      expect(model.iso6391, isNull);
      expect(model.name, isNull);
    });

    test('lê campo iso_639_1 com underscore corretamente', () {
      final json = {'iso_639_1': 'pt'};
      final model = SpokenLanguageApiModel.fromJson(json);
      expect(model.iso6391, equals('pt'));
    });
  });

  group('SpokenLanguageApiModel.toDomain', () {
    test('converte para SpokenLanguage com os mesmos valores', () {
      const model = SpokenLanguageApiModel(
        englishName: 'Portuguese',
        iso6391: 'pt',
        name: 'Português',
      );
      final domain = model.toDomain();

      expect(domain, isA<SpokenLanguage>());
      expect(domain.englishName, equals('Portuguese'));
      expect(domain.iso6391, equals('pt'));
      expect(domain.name, equals('Português'));
    });

    test('converte preservando campos null', () {
      const model = SpokenLanguageApiModel(
        englishName: null,
        iso6391: null,
        name: null,
      );
      final domain = model.toDomain();

      expect(domain.englishName, isNull);
      expect(domain.iso6391, isNull);
      expect(domain.name, isNull);
    });
  });
}
