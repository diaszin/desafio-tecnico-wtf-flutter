import 'package:desafio_tecnico_wtf/data/models/genre_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/production_company_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/spoken_language_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/mapper/movie_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/movie_fixture.dart';

void main() {
  group('MovieMapper.modelToDomain', () {
    test('mapeia todos os campos corretamente com model completo', () {
      final model = movieApiModelFixture();

      final movie = MovieMapper.modelToDomain(model);

      expect(movie.id, equals(1));
      expect(movie.title, equals('Inception'));
      expect(movie.originalTitle, equals('Inception'));
      expect(movie.overview, equals('A mind-bending thriller.'));
      expect(movie.releaseDate, equals(DateTime(2010, 7, 16)));
      expect(movie.runtime, equals(148));
      expect(movie.voteAverage, equals(8.8));
      expect(movie.voteCount, equals(30000));
      expect(movie.popularity, equals(150.0));
      expect(movie.budget, equals(160000000));
      expect(movie.revenue, equals(836800000));
      expect(movie.status, equals('Released'));
      expect(movie.originalLanguage, equals('en'));
      expect(movie.isAdult, isFalse);
      expect(movie.hasVideo, isFalse);
      expect(movie.posterPath, equals('/poster.jpg'));
      expect(movie.backdropPath, equals('/backdrop.jpg'));
    });

    test('mapeia listas (genres, production, languages) corretamente', () {
      final model = movieApiModelFixture(
        genres: [
          const GenreApiModel(id: 28, name: 'Action'),
          const GenreApiModel(id: 12, name: 'Adventure'),
        ],
        productionCompanies: [
          const ProductionCompanyApiModel(
            id: 1,
            name: 'Warner Bros.',
            logoPath: null,
            originCountry: 'US',
          ),
        ],
        spokenLanguages: [
          const SpokenLanguageApiModel(
            englishName: 'English',
            iso6391: 'en',
            name: 'English',
          ),
          const SpokenLanguageApiModel(
            englishName: 'French',
            iso6391: 'fr',
            name: 'Français',
          ),
        ],
      );

      final movie = MovieMapper.modelToDomain(model);

      expect(movie.genres.length, equals(2));
      expect(movie.genres[0].name, equals('Action'));
      expect(movie.genres[1].name, equals('Adventure'));

      expect(movie.production.length, equals(1));
      expect(movie.production[0].name, equals('Warner Bros.'));

      expect(movie.languages.length, equals(2));
      expect(movie.languages[0].englishName, equals('English'));
      expect(movie.languages[1].englishName, equals('French'));
    });

    test('retorna listas vazias quando genres, production e languages são null',
        () {
      final model = movieApiModelFixture(
        genres: null,
        productionCompanies: null,
        spokenLanguages: null,
      );

      final movie = MovieMapper.modelToDomain(model);

      expect(movie.genres, isEmpty);
      expect(movie.production, isEmpty);
      expect(movie.languages, isEmpty);
    });

    test('usa string vazia para overview quando null', () {
      final model = movieApiModelFixture(overview: null);
      final movie = MovieMapper.modelToDomain(model);
      expect(movie.overview, equals(''));
    });

    test('usa originalTitle como fallback quando originalTitle é null', () {
      final model = movieApiModelFixture(
        originalTitle: null,
        title: 'Inception',
      );
      final movie = MovieMapper.modelToDomain(model);
      expect(movie.originalTitle, equals('Inception'));
    });

    test('lança ArgumentError quando id é null', () {
      final model = movieApiModelFixture(id: null);
      expect(() => MovieMapper.modelToDomain(model), throwsArgumentError);
    });

    test('lança ArgumentError quando title é null', () {
      final model = movieApiModelFixture(title: null);
      expect(() => MovieMapper.modelToDomain(model), throwsArgumentError);
    });

    test('posterPathURL e backdropPathUrl são construídos corretamente', () {
      final model = movieApiModelFixture(
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
      );
      final movie = MovieMapper.modelToDomain(model);

      expect(movie.posterPathURL, equals('https://image.tmdb.org/t/p/w500/poster.jpg'));
      expect(movie.backdropPathUrl, equals('https://image.tmdb.org/t/p/w500/backdrop.jpg'));
    });

    test('isAdult e hasVideo padrão para false quando null', () {
      final model = movieApiModelFixture(adult: null, video: null);
      final movie = MovieMapper.modelToDomain(model);
      expect(movie.isAdult, isFalse);
      expect(movie.hasVideo, isFalse);
    });

    test('retorna instância do tipo Movie', () {
      final model = movieApiModelFixture();
      final result = MovieMapper.modelToDomain(model);
      expect(result, isA<Movie>());
    });
  });
}
