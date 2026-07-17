import 'package:flutter_test/flutter_test.dart';
import 'package:paradox_engine_swarm/core/config/llm_config.dart';
import 'package:paradox_engine_swarm/core/errors/exceptions.dart';

void main() {
  group('LLMConfig', () {
    test('fake backend passes validation', () {
      const config = LLMConfig(backend: LLMBackend.fake);
      expect(() => config.validate(), returnsNormally);
    });

    test('openai backend throws without apiKey', () {
      const config = LLMConfig(backend: LLMBackend.openai);
      expect(() => config.validate(), throwsA(isA<ConfigurationException>()));
    });

    test('openai backend passes with apiKey', () {
      const config = LLMConfig(backend: LLMBackend.openai, apiKey: 'sk-test');
      expect(() => config.validate(), returnsNormally);
    });

    test('local backend throws without localModelPath', () {
      const config = LLMConfig(backend: LLMBackend.local);
      expect(() => config.validate(), throwsA(isA<ConfigurationException>()));
    });

    test('local backend passes with localModelPath', () {
      const config = LLMConfig(
        backend: LLMBackend.local,
        localModelPath: '/models/test.gguf',
      );
      expect(() => config.validate(), returnsNormally);
    });
  });
}
