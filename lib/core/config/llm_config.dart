import '../errors/exceptions.dart';

enum LLMBackend { fake, openai, local }

class LLMConfig {
  const LLMConfig({
    required this.backend,
    this.apiKey,
    this.baseUrl = 'https://api.openai.com/v1',
    this.modelName = 'gpt-4o-mini',
    this.localModelPath,
  });

  final LLMBackend backend;
  final String? apiKey;
  final String baseUrl;
  final String modelName;
  final String? localModelPath;

  void validate() {
    switch (backend) {
      case LLMBackend.fake:
        return;
      case LLMBackend.openai:
        if (apiKey == null || apiKey!.trim().isEmpty) {
          throw const ConfigurationException('apiKey is required for OpenAI backend.');
        }
      case LLMBackend.local:
        if (localModelPath == null || localModelPath!.trim().isEmpty) {
          throw const ConfigurationException('localModelPath is required for local backend.');
        }
    }
  }
}
