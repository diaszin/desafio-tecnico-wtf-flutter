import 'dart:io';

import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/movie_fixture.dart';

Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        width: 400,
        height: 600,
        child: child,
      ),
    ),
  );
}

void main() {
  setUpAll(() {
    // Permite chamadas HTTP em testes para não travar no Image.network
    HttpOverrides.global = null;
  });

  group('FeaturedMovieSection — movie null', () {
    testWidgets('renderiza sem erro e sem conteúdo quando movie é null',
        (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          const FeaturedMovieSection(movie: null, summaryList: []),
        ),
      );

      expect(find.byType(FeaturedMovieSection), findsOneWidget);
      // Nenhum texto de título deve aparecer
      expect(find.byType(Stack), findsNothing);
    });
  });

  group('FeaturedMovieSection — movie com dados', () {
    testWidgets('renderiza título do filme', (tester) async {
      final movie = movieFixture(title: 'Inception');

      await tester.pumpWidget(
        _buildTestable(
          FeaturedMovieSection(movie: movie, summaryList: const []),
        ),
      );

      // Pump sem aguardar rede
      await tester.pump();

      expect(find.text('Inception'), findsOneWidget);
    });

    testWidgets('renderiza widgets do summaryList corretamente', (tester) async {
      final movie = movieFixture();

      await tester.pumpWidget(
        _buildTestable(
          FeaturedMovieSection(
            movie: movie,
            summaryList: const [
              Text('2010', key: Key('year')),
              Text('Action', key: Key('genre')),
            ],
          ),
        ),
      );

      await tester.pump();

      expect(find.text('2010'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
    });

    testWidgets('renderiza botão "Assistir agora"', (tester) async {
      final movie = movieFixture();

      await tester.pumpWidget(
        _buildTestable(
          FeaturedMovieSection(movie: movie, summaryList: const []),
        ),
      );

      await tester.pump();

      expect(find.text('Assistir agora'), findsOneWidget);
    });

    testWidgets('renderiza ícone de bookmark', (tester) async {
      final movie = movieFixture();

      await tester.pumpWidget(
        _buildTestable(
          FeaturedMovieSection(movie: movie, summaryList: const []),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
    });

    testWidgets('summaryList vazio não causa erro de renderização', (tester) async {
      final movie = movieFixture(title: 'Test Movie');

      await tester.pumpWidget(
        _buildTestable(
          FeaturedMovieSection(movie: movie, summaryList: const []),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Test Movie'), findsOneWidget);
    });
  });
}
