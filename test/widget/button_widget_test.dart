import 'package:desafio_tecnico_wtf/ui/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildTestable(Widget child) {
  return MaterialApp(home: Scaffold(body: Center(child: child)));
}

void main() {
  group('Button — renderização', () {
    testWidgets('exibe texto quando text é fornecido', (tester) async {
      await tester.pumpWidget(
        _buildTestable(Button(text: 'Assistir agora')),
      );

      expect(find.text('Assistir agora'), findsOneWidget);
    });

    testWidgets('renderiza ElevatedButton.icon quando text e icon fornecidos',
        (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          Button(text: 'Play', icon: Icons.play_arrow),
        ),
      );

      expect(find.byWidgetPredicate((w) => w is ElevatedButton), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('renderiza IconButton quando apenas icon fornecido (sem texto)',
        (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          Button(icon: Icons.bookmark_outline),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is ElevatedButton), findsNothing);
    });

    testWidgets('exibe ícone com cor customizada', (tester) async {
      const iconColor = Color(0xFFEDE8DD);

      await tester.pumpWidget(
        _buildTestable(
          Button(
            text: 'Teste',
            icon: Icons.star,
            iconColor: iconColor,
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, equals(iconColor));
    });
  });

  group('Button — cores por tipo', () {
    testWidgets('botão primary usa cor vermelha (0xFFEF233C)', (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          Button(text: 'Entrar', type: ButtonType.primary),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(
        find.byWidgetPredicate((w) => w is ElevatedButton),
      );
      final style = elevatedButton.style;
      final bgColor =
          style?.backgroundColor?.resolve({}) as Color?;

      expect(bgColor, equals(const Color(0xFFEF233C)));
    });

    testWidgets('botão secondary usa cor escura (0xFF1C1D21)', (tester) async {
      await tester.pumpWidget(
        _buildTestable(
          Button(
            icon: Icons.bookmark_outline,
            type: ButtonType.secondary,
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(
        find.byType(IconButton),
      );
      final style = iconButton.style;
      final bgColor =
          style?.backgroundColor?.resolve({}) as Color?;

      expect(bgColor, equals(const Color(0xFF1C1D21)));
    });
  });

  group('Button — interação', () {
    testWidgets('chama onPressed ao ser tocado', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        _buildTestable(
          Button(
            text: 'Entrar',
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byWidgetPredicate((w) => w is ElevatedButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('onPressed padrão não lança exceção ao tocar', (tester) async {
      await tester.pumpWidget(
        _buildTestable(Button(text: 'Sem ação')),
      );

      expect(
        () async => await tester.tap(find.byWidgetPredicate((w) => w is ElevatedButton)),
        returnsNormally,
      );
    });

    testWidgets('IconButton chama onPressed ao ser tocado', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        _buildTestable(
          Button(
            icon: Icons.favorite,
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });

  group('Button — largura', () {
    testWidgets('aplica width customizada quando fornecida', (tester) async {
      const customWidth = 200.0;

      await tester.pumpWidget(
        _buildTestable(
          Button(text: 'Teste', width: customWidth),
        ),
      );

      final sizedBox = tester.widget<ElevatedButton>(
        find.byWidgetPredicate((w) => w is ElevatedButton),
      );
      final fixedSize = sizedBox.style?.fixedSize?.resolve({});
      expect(fixedSize?.width, equals(customWidth));
    });
  });
}
