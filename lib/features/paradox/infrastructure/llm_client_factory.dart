import '../../core/config/llm_config.dart';
import 'llm_client.dart';
import 'fake_llm_client.dart';
import 'openai_client.dart';
import 'local_llm_client.dart';

LLMClient createLLMClient(LLMConfig config) {
  switch (config.backend) {
    case LLMBackend.fake:
      return FakeLLMClient();
    case LLMBackend.openai:
      return OpenAIClient(config);
    case LLMBackend.local:
      return LocalLLMClient(config);
  }
}
