import 'package:flutter/material.dart';
import '../../../core/config/llm_config.dart';
import '../../../core/errors/exceptions.dart';
import '../application/blackboard.dart';
import '../application/banality_detector.dart';
import '../application/paradox_orchestrator.dart';
import '../domain/models/paradox_cloud.dart';
import '../infrastructure/llm_client.dart';
import '../infrastructure/llm_client_factory.dart';

class ParadoxController extends ChangeNotifier {
  String topic = '';
  LLMBackend selectedBackend = LLMBackend.fake;
  String apiKey = '';
  String baseUrl = 'https://api.openai.com/v1';
  String modelName = 'gpt-4o-mini';
  String localModelPath = '';
  int maxRounds = 1;
  ParadoxCloud? lastCloud;
  bool isLoading = false;
  String? errorMessage;

  Future<void> generate() async {
    isLoading = true;
    errorMessage = null;
    lastCloud = null;
    notifyListeners();

    try {
      final config = LLMConfig(
        backend: selectedBackend,
        apiKey: selectedBackend == LLMBackend.openai ? apiKey : null,
        baseUrl: baseUrl,
        modelName: modelName,
        localModelPath: selectedBackend == LLMBackend.local ? localModelPath : null,
      );
      config.validate();

      final LLMClient llmClient = createLLMClient(config);
      final blackboard = Blackboard();
      final detector = BanalityDetector();
      final orchestrator = ParadoxOrchestrator(
        llmClient: llmClient,
        blackboard: blackboard,
        banalityDetector: detector,
        maxRounds: maxRounds,
      );

      lastCloud = await orchestrator.run(topic);
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
