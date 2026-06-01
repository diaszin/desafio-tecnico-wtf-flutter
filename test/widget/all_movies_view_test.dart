import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/all_movies_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

import '../fixtures/movie_fixture.dart';
import '../mocks/mock_movie_repository.dart';

GoRouter _buildTestRouter({Widget? detailPage}) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => const AllMoviesView(),
      ),
      GoRoute(
        path: '/movie/:movieid',
        builder: (_, __) =>
            detailPage ?? const Scaffold(body: Text('Detalhe')),
      ),
    ],
  );
}

Widget _buildTestable({
  required MockMovieRepository mockRepository,
  Widget? detailPage,
}) {
  final viewModel = AllMoviesViewModel(
    movieRepository: mockRepository,
    logger: Logger(filter: ProductionFilter()),
  );

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AllMoviesViewModel>.value(value: viewModel),
    ],
    child: MaterialApp.router(
      routerConfig: _buildTestRouter(detailPage: detailPage),
    ),
  );
}

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  group('AllMoviesView — estado loading (isRunning)', () {
    testWidgets('exibe shimmer enquanto command está em execução', (tester) async {
      // Simula delay infinito para manter estado running
      mockRepository.getPopularMoviesResult = Success(movieListFixture());

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      // Apenas pump (não pumpAndSettle) para capturar o estado de loading
      await tester.pump();

      expect(find.byType(FeaturedMovieSectionShimmer), findsOneWidget);
    });
  });

  group('AllMoviesView — estado de falha (isFailure)', () {
    testWidgets('exibe mensagem de erro após falha', (tester) async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(
        find.text('Ops! Não conseguimos consultar os filmes'),
        findsOneWidget,
      );
    });

    testWidgets('exibe botão "Tentar novamente" após falha', (tester) async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Tentar novamente'), findsOneWidget);
    });

    testWidgets(
        'tap em "Tentar novamente" chama repository novamente',
        (tester) async {
      mockRepository.getPopularMoviesResult =
          Failure(Exception('Erro de rede'));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      final callsBefore = mockRepository.getPopularMoviesCallCount;

      await tester.tap(find.text('Tentar novamente'));
      await tester.pump();

      expect(
        mockRepository.getPopularMoviesCallCount,
        greaterThan(callsBefore),
      );
    });
  });

  group('AllMoviesView — estado de sucesso (isSuccess)', () {
    testWidgets('exibe título "Populares no momento" após sucesso', (tester) async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 3));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.text('Populares no momento'), findsOneWidget);
    });

    testWidgets('exibe shimmer NÃO está presente após sucesso', (tester) async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 2));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(find.byType(FeaturedMovieSectionShimmer), findsNothing);
    });

    testWidgets('mensagem de erro NÃO está presente após sucesso', (tester) async {
      mockRepository.getPopularMoviesResult =
          Success(movieListFixture(count: 2));

      await tester.pumpWidget(_buildTestable(mockRepository: mockRepository));
      await tester.pumpAndSettle();

      expect(
        find.text('Ops! Não conseguimos consultar os filmes'),
        findsNothing,
      );
    });
  });
}
