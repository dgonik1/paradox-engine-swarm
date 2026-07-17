import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:paradox_engine_swarm/features/paradox/presentation/paradox_controller.dart';
import 'package:paradox_engine_swarm/features/paradox/presentation/paradox_page.dart';

void main() {
  testWidgets('ParadoxPage shows generate button', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ParadoxController(),
        child: const MaterialApp(home: ParadoxPage()),
      ),
    );

    expect(find.text('Generate Paradoxes'), findsOneWidget);
    expect(find.text('Topic'), findsOneWidget);
  });
}
