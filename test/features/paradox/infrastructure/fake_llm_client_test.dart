import 'package:flutter_test/flutter_test.dart';
import 'package:paradox_engine_swarm/features/paradox/infrastructure/fake_llm_client.dart';

void main() {
  group('FakeLLMClient', () {
    late FakeLLMClient client;

    setUp(() {
      client = FakeLLMClient();
    });

    test('returns non-empty response', () async {
      final result = await client.complete(
        systemPrompt: 'You are the Provocateur.',
        userPrompt: 'Topic: consciousness',
      );
      expect(result, isNotEmpty);
    });

    test('returns banal synthesist response after enough calls', () async {
      // Call 3 times with Provocateur/Analyst, then Synthesist on 4th
      await client.complete(systemPrompt: 'Provocateur', userPrompt: 'Topic: x');
      await client.complete(systemPrompt: 'Analyst', userPrompt: 'Topic: x');
      await client.complete(systemPrompt: 'Provocateur', userPrompt: 'Topic: x');
      final result = await client.complete(
        systemPrompt: 'You are the Synthesist.',
        userPrompt: 'Topic: x',
      );
      expect(result, contains('depends'));
    });
  });
}
