import '../../core/config/llm_config.dart';
import '../../core/errors/exceptions.dart';
import 'llm_client.dart';

class LocalLLMClient extends LLMClient {
  LocalLLMClient(this._config);

  final LLMConfig _config;

  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final path = _config.localModelPath;
    if (path == null || path.isEmpty) {
      throw const LLMClientError('Local model path is not configured.');
    }

    // Stub: real implementation would use dart:ffi with llama.cpp or
    // a platform channel to a native model runner.
    return '[Local model stub] Response to: ${userPrompt.substring(0, userPrompt.length.clamp(0, 80))}';
  }
}
