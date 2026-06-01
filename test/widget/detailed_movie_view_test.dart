import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/detailed_movie_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

import '../fixtures/movie_fixture.dart';
import '../mocks/mock_movie_repository.dart';

Widget _buildTestable({
  required MockMovieRepository mockRepository,
  int movieId = 1,
}) {
  final viewModel = MovieViewModel(
    movieRepository: mockRepository,
    logger: Logger(filter: ProductionFilter()),
  );

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MovieViewModel>.value(value: viewModel),
    ],
    child: MaterialApp(
      home: DetailedMovieView(id: movieId),
    ),
  );
}

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  group('DetailedMovieView — estado loading (isRunning)', () {
    testWidgets('exibe shimmer enquanto command está em execução', (tester) async {
      mockRepository.getMovieResult = Success(movieFixture());

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      // Pump sem settle para capturar o estado de loading
      await tester.pump();

      expect(find.byType(FeaturedMovieSectionShimmer), findsOneWidget);
    });
  });

  group('DetailedMovieView — estado de falha (isFailure)', () {
    testWidgets('exibe mensagem de desculpas após falha', (tester) async {
      mockRepository.getMovieResult =
          Failure(Exception('Filme não encontrado'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Pedimos desculpas! Não conseguimos encontrar o filme selecionado',
        ),
        findsOneWidget,
      );
    });

    testWidgets('exibe botão "Tentar novamente" após falha', (tester) async {
      mockRepository.getMovieResult =
          Failure(Exception('Filme não encontrado'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Tentar novamente'), findsOneWidget);
    });

    testWidgets('tap em "Tentar novamente" chama repository novamente',
        (tester) async {
      mockRepository.getMovieResult =
          Failure(Exception('Filme não encontrado'));

      await tester.pumpWidget(
        _buildTestable(mockRepository: mockRepository, movieId: 5),
      );
      await tester.pumpAndSettle();

      final callsBefore = mockRepository.getMovieCallCount;

      await tester.tap(find.text('Tentar novamente'));
      await tester.pump();

      expect(mockRepository.getMovieCallCount, greaterThan(callsBefore));
    });

    testWidgets('shimmer NÃO está presente após falha', (tester) async {
      mockRepository.getMovieResult =
          Failure(Exception('Filme não encontrado'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.byType(FeaturedMovieSectionShimmer), findsNothing);
    });
  });

  group('DetailedMovieView — estado de sucesso (isSuccess)', () {
    testWidgets('exibe título do filme após sucesso', (tester) async {
      final movie = movieFixture(title: 'Inception');
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Inception'), findsOneWidget);
    });

    testWidgets('exibe overview do filme após sucesso', (tester) async {
      final movie = movieFixture(overview: 'A mind-bending thriller.');
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('A mind-bending thriller.'), findsOneWidget);
    });

    testWidgets('exibe seção Produtoras com nome da empresa', (tester) async {
      final movie = movieFixture();
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Produtoras:'), findsOneWidget);
      expect(find.text('Warner Bros.'), findsOneWidget);
    });

    testWidgets('exibe seção Orçamento', (tester) async {
      final movie = movieFixture(budget: 160000000);
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Orçamento:'), findsOneWidget);
      // 160 milhões
      expect(find.text('US\$ 160.0 milhões'), findsOneWidget);
    });

    testWidgets('exibe "Não divulgado" quando budget é 0', (tester) async {
      final movie = movieFixture(budget: 0);
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Não divulgado'), findsAtLeastNWidgets(1));
    });

    testWidgets('exibe seção Idiomas com nome do idioma', (tester) async {
      final movie = movieFixture();
      mockRepository.getMovieResult = Success(movie);

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Idiomas:'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('shimmer NÃO está presente após sucesso', (tester) async {
      mockRepository.getMovieResult = Success(movieFixture());

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.byType(FeaturedMovieSectionShimmer), findsNothing);
    });

    testWidgets('passa o id correto ao repository', (tester) async {
      mockRepository.getMovieResult = Success(movieFixture(id: 42));

      await tester.pumpWidget(
        _buildTestable(mockRepository: mockRepository, movieId: 42),
      );
      await tester.pumpAndSettle();

      expect(mockRepository.lastRequestedMovieId, equals(42));
    });
  });
}
