import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/llm_config.dart';
import 'paradox_controller.dart';

class ParadoxPage extends StatelessWidget {
  const ParadoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ParadoxController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Paradox Engine Swarm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Topic'),
              onChanged: (value) => controller.topic = value,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LLMBackend>(
              value: controller.selectedBackend,
              decoration: const InputDecoration(labelText: 'LLM Backend'),
              items: const [
                DropdownMenuItem(value: LLMBackend.fake, child: Text('Fake (demo)')),
                DropdownMenuItem(value: LLMBackend.openai, child: Text('OpenAI API')),
                DropdownMenuItem(value: LLMBackend.local, child: Text('Local model')),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.selectedBackend = value;
                  controller.notifyListeners();
                }
              },
            ),
            if (controller.selectedBackend == LLMBackend.openai) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'API Key'),
                obscureText: true,
                onChanged: (value) => controller.apiKey = value,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Base URL'),
                onChanged: (value) => controller.baseUrl = value,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Model name'),
                onChanged: (value) => controller.modelName = value,
              ),
            ],
            if (controller.selectedBackend == LLMBackend.local) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Local model path'),
                onChanged: (value) => controller.localModelPath = value,
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Max rounds:'),
                Expanded(
                  child: Slider(
                    value: controller.maxRounds.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '${controller.maxRounds}',
                    onChanged: (value) {
                      controller.maxRounds = value.round();
                      controller.notifyListeners();
                    },
                  ),
                ),
                Text('${controller.maxRounds}'),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.isLoading ? null : () => controller.generate(),
              child: controller.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Generate Paradoxes'),
            ),
            if (controller.errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                controller.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            if (controller.lastCloud != null) ...[
              const SizedBox(height: 24),
              Text('Topic: ${controller.lastCloud!.topic}'),
              Text('Rounds: ${controller.lastCloud!.rounds.length}'),
              Text('Banal syntheses: ${controller.lastCloud!.rounds.where((r) => r.banalityDetected).length}'),
              const SizedBox(height: 16),
              ...controller.lastCloud!.finalStatements.map(
                (stmt) => Card(
                  child: ListTile(
                    title: Text('[${stmt.role.value}] (round ${stmt.round})'),
                    subtitle: Text(stmt.content),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
