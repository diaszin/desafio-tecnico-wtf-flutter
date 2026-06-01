import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../fixtures/movie_fixture.dart';
import '../../mocks/mock_movie_repository.dart';

void main() {
  late MockMovieRepository mockRepository;
  late AllMoviesViewModel viewModel;

  setUp(() {
    mockRepository = MockMovieRepository();
    viewModel = AllMoviesViewModel(
      movieRepository: mockRepository,
      logger: Logger(filter: ProductionFilter()),
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('AllMoviesViewModel — estado inicial', () {
    test('popularMovies começa vazio', () {
      expect(viewModel.popularMovies, isEmpty);
    });

    test('featuredMovie retorna null quando lista vazia', () {
      expect(viewModel.featuredMovie, isNull);
    });

    test('loadPopularMoviesCommand não está em execução inicialmente', () {
      expect(viewModel.loadPopularMoviesCommand.value.isRunning, isFalse);
    });
  });

  group('AllMoviesViewModel — loadPopularMoviesCommand com sucesso', () {
    test('preenche popularMovies após sucesso', () async {
      final movies = movieListFixture(count: 3);
      mockRepository.getPopularMoviesResult = Success(movies);

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.popularMovies.length, equals(3));
      expect(viewModel.popularMovies[0].title, equals('Movie 1'));
    });

    test('featuredMovie é o primeiro filme da lista após sucesso', () async {
      final movies = movieListFixture(count: 5);
      mockRepository.getPopularMoviesResult = Success(movies);

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.featuredMovie, isNotNull);
      expect(viewModel.featuredMovie!.id, equals(movies.first.id));
    });

    test('command fica isSuccess após execução bem-sucedida', () async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 2));

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.loadPopularMoviesCommand.value.isSuccess, isTrue);
    });

    test('chama getPopularMovies exatamente uma vez', () async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 1));

      await viewModel.loadPopularMoviesCommand.execute();

      expect(mockRepository.getPopularMoviesCallCount, equals(1));
    });
  });

  group('AllMoviesViewModel — loadPopularMoviesCommand com falha', () {
    test('popularMovies permanece vazio após falha', () async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.popularMovies, isEmpty);
    });

    test('command fica isFailure após falha', () async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.loadPopularMoviesCommand.value.isFailure, isTrue);
    });

    test('featuredMovie retorna null após falha', () async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await viewModel.loadPopularMoviesCommand.execute();

      expect(viewModel.featuredMovie, isNull);
    });
  });

  group('AllMoviesViewModel — notificações de mudança', () {
    test('notifica listeners após carregamento com sucesso', () async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 2));

      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      await viewModel.loadPopularMoviesCommand.execute();

      expect(notifyCount, greaterThan(0));
    });
  });
}
