import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/paradox/presentation/paradox_controller.dart';
import '../features/paradox/presentation/paradox_page.dart';

class ParadoxEngineApp extends StatelessWidget {
  const ParadoxEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParadoxController(),
      child: MaterialApp(
        title: 'Paradox Engine Swarm',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ParadoxPage(),
      ),
    );
  }
}
