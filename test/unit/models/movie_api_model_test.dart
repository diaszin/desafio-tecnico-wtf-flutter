import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/movie_fixture.dart';

void main() {
  group('MovieApiModel.fromJson', () {
    test('desserializa JSON completo corretamente', () {
      final json = movieJsonFixture();
      final model = MovieApiModel.fromJson(json);

      expect(model.id, equals(1));
      expect(model.title, equals('Inception'));
      expect(model.originalTitle, equals('Inception'));
      expect(model.overview, equals('A mind-bending thriller.'));
      expect(model.releaseDate, equals('2010-07-16'));
      expect(model.runtime, equals(148));
      expect(model.voteAverage, equals(8.8));
      expect(model.voteCount, equals(30000));
      expect(model.popularity, equals(150.0));
      expect(model.budget, equals(160000000));
      expect(model.revenue, equals(836800000));
      expect(model.status, equals('Released'));
      expect(model.originalLanguage, equals('en'));
      expect(model.adult, isFalse);
      expect(model.video, isFalse);
      expect(model.posterPath, equals('/poster.jpg'));
      expect(model.backdropPath, equals('/backdrop.jpg'));
      expect(model.homepage, equals('https://inception.com'));
      expect(model.imdbId, equals('tt1375666'));
      expect(model.tagline, equals('Your mind is the scene of the crime.'));
    });

    test('desserializa listas aninhadas (genres, companies, languages)', () {
      final json = movieJsonFixture();
      final model = MovieApiModel.fromJson(json);

      expect(model.genres, isNotNull);
      expect(model.genres!.length, equals(2));
      expect(model.genres![0].id, equals(28));
      expect(model.genres![0].name, equals('Action'));

      expect(model.productionCompanies, isNotNull);
      expect(model.productionCompanies!.length, equals(1));
      expect(model.productionCompanies![0].name, equals('Warner Bros.'));

      expect(model.spokenLanguages, isNotNull);
      expect(model.spokenLanguages!.length, equals(1));
      expect(model.spokenLanguages![0].englishName, equals('English'));
    });

    test('campos opcionais ficam null quando ausentes no JSON', () {
      final json = <String, dynamic>{
        'id': 42,
        'title': 'Minimal Movie',
        'release_date': '2020-01-01',
      };
      final model = MovieApiModel.fromJson(json);

      expect(model.id, equals(42));
      expect(model.title, equals('Minimal Movie'));
      expect(model.overview, isNull);
      expect(model.budget, isNull);
      expect(model.genres, isNull);
      expect(model.productionCompanies, isNull);
      expect(model.spokenLanguages, isNull);
      expect(model.posterPath, isNull);
      expect(model.backdropPath, isNull);
    });

    test('converte popularity como double quando API envia int', () {
      final json = movieJsonFixture()..['popularity'] = 200;
      final model = MovieApiModel.fromJson(json);
      expect(model.popularity, equals(200.0));
      expect(model.popularity, isA<double>());
    });

    test('converte voteAverage como double quando API envia int', () {
      final json = movieJsonFixture()..['vote_average'] = 8;
      final model = MovieApiModel.fromJson(json);
      expect(model.voteAverage, equals(8.0));
      expect(model.voteAverage, isA<double>());
    });

    test('origin_country é desserializado como lista de strings', () {
      final json = movieJsonFixture();
      final model = MovieApiModel.fromJson(json);
      expect(model.originCountry, equals(['US']));
    });

    test('belongs_to_collection null não causa erro', () {
      final json = movieJsonFixture()..['belongs_to_collection'] = null;
      expect(() => MovieApiModel.fromJson(json), returnsNormally);
    });
  });

  group('ProductionCountry.fromJson', () {
    test('desserializa iso_3166_1 e name corretamente', () {
      final json = {'iso_3166_1': 'US', 'name': 'United States of America'};
      final country = ProductionCountry.fromJson(json);
      expect(country.iso31661, equals('US'));
      expect(country.name, equals('United States of America'));
    });

    test('toJson gera mapa correto', () {
      const country = ProductionCountry(
        iso31661: 'BR',
        name: 'Brazil',
      );
      final json = country.toJson();
      expect(json['iso_3166_1'], equals('BR'));
      expect(json['name'], equals('Brazil'));
    });
  });
}
