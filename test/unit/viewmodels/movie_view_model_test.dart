import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../fixtures/movie_fixture.dart';
import '../../mocks/mock_movie_repository.dart';

void main() {
  late MockMovieRepository mockRepository;
  late MovieViewModel viewModel;

  setUp(() {
    mockRepository = MockMovieRepository();
    viewModel = MovieViewModel(
      movieRepository: mockRepository,
      logger: Logger(filter: ProductionFilter()),
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('MovieViewModel — estado inicial', () {
    test('movie começa null', () {
      expect(viewModel.movie, isNull);
    });

    test('loadMovie command não está em execução inicialmente', () {
      expect(viewModel.loadMovie.value.isRunning, isFalse);
    });
  });

  group('MovieViewModel — loadMovie com sucesso', () {
    test('preenche movie após sucesso', () async {
      final movie = movieFixture(id: 42, title: 'Interstellar');
      mockRepository.getMovieResult = Success(movie);

      await viewModel.loadMovie.execute(42);

      expect(viewModel.movie, isNotNull);
      expect(viewModel.movie!.id, equals(42));
      expect(viewModel.movie!.title, equals('Interstellar'));
    });

    test('command fica isSuccess após execução bem-sucedida', () async {
      mockRepository.getMovieResult = Success(movieFixture());

      await viewModel.loadMovie.execute(1);

      expect(viewModel.loadMovie.value.isSuccess, isTrue);
    });

    test('passa o id correto ao repository', () async {
      mockRepository.getMovieResult = Success(movieFixture(id: 99));

      await viewModel.loadMovie.execute(99);

      expect(mockRepository.lastRequestedMovieId, equals(99));
    });

    test('chama getMovie exatamente uma vez', () async {
      mockRepository.getMovieResult = Success(movieFixture());

      await viewModel.loadMovie.execute(1);

      expect(mockRepository.getMovieCallCount, equals(1));
    });
  });

  group('MovieViewModel — loadMovie com falha', () {
    test('movie permanece null após falha', () async {
      mockRepository.getMovieResult = Failure(Exception('Filme não encontrado'));

      await viewModel.loadMovie.execute(999);

      expect(viewModel.movie, isNull);
    });

    test('command fica isFailure após falha', () async {
      mockRepository.getMovieResult = Failure(Exception('Filme não encontrado'));

      await viewModel.loadMovie.execute(999);

      expect(viewModel.loadMovie.value.isFailure, isTrue);
    });
  });

  group('MovieViewModel — múltiplas execuções', () {
    test('atualiza movie quando execute chamado com id diferente', () async {
      final first = movieFixture(id: 1, title: 'First Movie');
      final second = movieFixture(id: 2, title: 'Second Movie');

      mockRepository.getMovieResult = Success(first);
      await viewModel.loadMovie.execute(1);
      expect(viewModel.movie!.title, equals('First Movie'));

      mockRepository.getMovieResult = Success(second);
      await viewModel.loadMovie.execute(2);
      expect(viewModel.movie!.title, equals('Second Movie'));
    });
  });

  group('MovieViewModel — notificações de mudança', () {
    test('notifica listeners após carregamento com sucesso', () async {
      mockRepository.getMovieResult = Success(movieFixture());

      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      await viewModel.loadMovie.execute(1);

      expect(notifyCount, greaterThan(0));
    });
  });
}
