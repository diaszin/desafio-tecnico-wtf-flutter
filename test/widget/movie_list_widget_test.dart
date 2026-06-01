import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../fixtures/movie_fixture.dart';

/// Cria um [GoRouter] mínimo para testes, com suporte às rotas usadas pelo app.
GoRouter _buildTestRouter({required Widget home}) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => home),
      GoRoute(
        path: '/movie/:movieid',
        builder: (_, __) => const Scaffold(body: Text('Detalhe do Filme')),
      ),
    ],
  );
}

Widget _buildTestable(Widget child) {
  return MaterialApp.router(
    routerConfig: _buildTestRouter(home: Scaffold(body: child)),
  );
}

void main() {
  group('MovieList — lista nula', () {
    testWidgets('renderiza SizedBox.shrink quando moviesList é null',
        (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          const MovieList(title: 'Populares', moviesList: null),
        ),
      );

      await tester.pumpAndSettle();

      // Sem título visível, sem cards
      expect(find.text('Populares'), findsNothing);
    });
  });

  group('MovieList — lista com filmes', () {
    testWidgets('exibe o título da seção', (tester) async {
      final movies = movieListFixture(count: 2);

      await tester.pumpWidget(
        _buildTestable(
          MovieList(title: 'Populares no momento', moviesList: movies),
        ),
      );

      await tester.pump();

      expect(find.text('Populares no momento'), findsOneWidget);
    });

    testWidgets('renderiza o número correto de cards', (tester) async {
      final movies = movieListFixture(count: 3);

      await tester.pumpWidget(
        _buildTestable(
          MovieList(title: 'Filmes', moviesList: movies),
        ),
      );

      await tester.pump();

      expect(find.byType(GestureDetector), findsNWidgets(3));
    });

    testWidgets('lista vazia não causa erro', (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          const MovieList(title: 'Filmes', moviesList: []),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Filmes'), findsOneWidget);
    });
  });

  group('MovieList — navegação', () {
    testWidgets('tap no card navega para /movie/:id', (tester) async {
      final movies = movieListFixture(count: 1);

      await tester.pumpWidget(
        _buildTestable(
          MovieList(title: 'Filmes', moviesList: movies),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Verifica que navegou para a tela de detalhe
      expect(find.text('Detalhe do Filme'), findsOneWidget);
    });
  });

  group('MovieList — height customizada', () {
    testWidgets('usa height padrão de 200 quando não especificada', (tester) async {
      final movies = movieListFixture(count: 1);

      await tester.pumpWidget(
        _buildTestable(
          MovieList(title: 'Filmes', moviesList: movies),
        ),
      );

      await tester.pump();

      final sizedBox = tester.widget<SizedBox>(
        find.byType(SizedBox).last,
      );
      expect(sizedBox.height, equals(200.0));
    });

    testWidgets('aplica height customizada quando fornecida', (tester) async {
      final movies = movieListFixture(count: 1);

      await tester.pumpWidget(
        _buildTestable(
          MovieList(title: 'Filmes', moviesList: movies, height: 150),
        ),
      );

      await tester.pump();

      final sizedBoxes = tester
          .widgetList<SizedBox>(find.byType(SizedBox))
          .where((s) => s.height == 150.0)
          .toList();

      expect(sizedBoxes, isNotEmpty);
    });
  });
}
